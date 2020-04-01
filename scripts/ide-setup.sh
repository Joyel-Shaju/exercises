echo "------------------------------------------------------------------------"
echo "Starting IDE Setup"
echo "------------------------------------------------------------------------"
WORKING_DIRECTORY="$PWD"
mkdir setup-repo && cd setup-repo
echo "Installing Kubectl"

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl

curl -o kubectl.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/kubectl.sha256

openssl sha1 -sha256 kubectl

chmod +x ./kubectl

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

kubectl version --short --client

echo "Installing aws-iam-authenticator"

curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator

curl -o aws-iam-authenticator.sha256 https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator.sha256

openssl sha1 -sha256 aws-iam-authenticator

chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin

echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

aws-iam-authenticator help

echo "Updating KubeConfig"  

aws eks --region eu-west-2 update-kubeconfig --name prod-ak-k8s-cluster

echo "Installing Python 3.7"

cd /usr/src

sudo wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz

sudo tar xzf Python-3.7.4.tgz

cd Python-3.7.4

sudo ./configure --enable-optimizations

sudo make altinstall

pip install --upgrade pip
pip install pipenv

cd $WORKING_DIRECTORY
echo "------------------------------------------------------------------------"
echo "Setup Completed"
echo "------------------------------------------------------------------------"