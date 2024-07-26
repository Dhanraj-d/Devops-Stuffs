

KAFKA_UNZIPPED_DIR_NAME='kafka_2.12-2.6.2'


# install java
sudo apt install default-jre -y
sudo apt install default-jdk -y

# check java version
java -version

#get-kafka
sudo wget https://archive.apache.org/dist/kafka/2.6.2/kafka_2.12-2.6.2.tgz

#unzip
tar -xzf kafka_2.12-2.6.2.tgz

#re-name
sudo mv $KAFKA_UNZIPPED_DIR_NAME kafka

#install unzip 
sudo apt install unzip


# install docker
sudo apt-get install ca-certificates curl gnupg lsb-release -y 
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


# install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# verify
sudo docker-compose --version