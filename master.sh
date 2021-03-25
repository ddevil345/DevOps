#!/bin/bash
echo "--- Start  Master script ----"
echo "--- mkdir /vagrant/ ----"
sudo mkdir /vagrant
echo "Initialize Kubernetes Cluster"

$CLIP=$(ip addr show | grep -o "inet 192\.[0-9]*\.[0-9]*\.[0-9]*" | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")

echo "* Initialize Kubernetes cluster ..."
sudo kubeadm init --apiserver-advertise-address=$CLIP --pod-network-cidr 10.244.0.0/16

echo "* Copy configuration for root ..."
sudo mkdir -p /root/.kube
sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config
sudo chown root:root /root/.kube/config

echo "* Copy configuration for vagrant ..."
mkdir -p /home/anton/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/anton/.kube/config
sudo chown anton:anton /home/anton/.kube/config

echo "* Install POD network plugin (Calico) ..."
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
wget https://docs.projectcalico.org/manifests/custom-resources.yaml -O /tmp/custom-resources.yaml
sed -i 's/192.168.0.0/10.244.0.0/g' /tmp/custom-resources.yaml
kubectl create -f /tmp/custom-resources.yaml

echo "* Install Dashboard ..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.3/aio/deploy/recommended.yaml

echo "* Create Dashboard admin user ..."
cat << EOF > /vagrant/dashboard-admin-user.yml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF

echo "* Create Dashboard admin user role ..."
cat << EOF > /vagrant/dashboard-admin-role.yml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

echo "* Add both the user and role ..."
kubectl apply -f /vagrant/dashboard-admin-user.yml
kubectl apply -f /vagrant/dashboard-admin-role.yml

echo "* Save the user token ..."
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}') > /vagrant/admin-user-token.txt

echo "gen ramdom token"
TOKEN=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

echo "* Create custom token ..."
kubeadm token create $TOKEN

echo "* Save the hash to a file ..."
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //' > /vagrant/hash.txt
echo "--- my join --- "
kubeadm token create --print-join-command >> /vagrant/join.sh
chmod 755 /vagrant/join.sh
echo "--- Finish Master script ----"
