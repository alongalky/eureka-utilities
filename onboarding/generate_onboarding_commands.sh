#!/bin/sh

account=$(python -c "import uuid; print str(uuid.uuid4())")
key=$(python -c "import uuid; print str(uuid.uuid4())")
secret=$(python -c "import uuid; print str(uuid.uuid4())")
machine=$(python -c "import uuid; print str(uuid.uuid4())")
mkdir $account
ssh-keygen -f $account/eureka_key -N "" -q
publickey=$(cat $account/eureka_key.pub | awk '{print $1,$2}')

cat <<EOI
Make gCloud bucket, upload private key to private-key bucket & config file to configfiles storage
gsutil mb -c regional -p $PROJECT_NAME -l us-east1 gs://eureka-account-$account/
gsutil cp $account/eureka_key gs://${PROJECT_NAME}-privatekeys/$account/
gsutil cp $account/eureka.config.yaml gs://${PROJECT_NAME}-configfiles/$account/

Insert into accounts (requires adding user details)
INSERT INTO \`accounts\` (\`account_id\`, \`name\`, \`key\`, \`secret\`, \`first_name\`, \`last_name\`, \`email\`, \`spending_quota\`, \`vm_quota\`, \`public_key\`) VALUES ('$account',<customer-company/name>,'$key','$secret',<firstname>,<lastname>,<email>,'100.0',10,'$publickey');

Find out the IP of the machinas machine, SSH, and mount cloud storage:
machinas_ip=\$(gcloud compute instances list --project $PROJECT_NAME | grep machinas-${PROJECT_NAME} | awk '{print \$5}')
ssh -A \$machinas_ip
sudo mkdir /mnt/eureka-account-$account
sudo gcsfuse eureka-account-$account /mnt/eureka-account-$account

Still in machinas, run the user docker container:
git clone git@bitbucket.org:alongalky/utility-scripts.git
cd utility-scripts/dockerfiles/numpy
git pull
sudo docker build . -t numpy-ssh
sudo docker run -i -t -d -p 3000-4000:22 -v /mnt/eureka-account-$account/:/keep -e "PUBLIC_KEY=$publickey" numpy-ssh

Parse the container and port
container=\$(sudo docker ps | sed -n "2p" | awk '{print \$1}')
port=\$(sudo docker port \$container | sed -rn 's/.+:(.+)\$/\1/p')
echo \$container \$port

Insert the new machine. Requires changing container and port
INSERT INTO \`machines\` (\`machine_id\`, \`name\`, \`account_id\`, \`vm_id\`, \`container_id\`, \`ssh_port\`) VALUES ('$machine', 'machina', '$account', 'machinas-$PROJECT_NAME', '<container-id>', '<port>');

EOI

userconfigfile=$account/eureka.config.yaml
echo "key: $key" > $userconfigfile
echo "secret: $secret" >> $userconfigfile
echo "account: $account" >> $userconfigfile
echo "endpoint: https://$PROJECT_NAME.appspot.com" >> $userconfigfile

