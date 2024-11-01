curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/$(uname -s | tr '[:upper:]' '[:lower:]')/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --clientkubectl get nodes

aws eks create-cluster --region us-east-1 --name lsc-cluster --role-arn arn:aws:iam::543856997581:role/LabRole --resources-vpc-config subnetIds=subnet-022ff6b6a360ab879,subnet-0128dfadcb984da7e,securityGroupIds=sg-02c4d1e6eb1b4ec08
aws eks --region us-east-1 update-kubeconfig --name lsc-cluster
aws eks create-nodegroup --cluster-name lsc-cluster --nodegroup-name lsc-ng --node-role arn:aws:iam::543856997581:role/LabRole --subnet subnet-022ff6b6a360ab879 subnet-0128dfadcb984da7e --instance-types t3.medium --scaling-config minSize=1,maxSize=2,desiredSize=1 --disk-size 20 --ami-type AL2_x86_64

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

helm repo add nfs-ganesha-server-and-external-provisioner https://kubernetes-sigs.github.io/nfs-ganesha-server-and-external-provisioner/
helm install nfs-server-provisioner nfs-ganesha-server-and-external-provisioner/nfs-server-provisioner -f ./nfs-values.yaml

kubectl apply -f ./files/pvc.yaml
kubectl apply -f ./files/deployment.yaml
kubectl apply -f ./files/service.yaml
kubectl apply -f ./files/job.yaml