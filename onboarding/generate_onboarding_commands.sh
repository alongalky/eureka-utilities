#!/bin/sh

account=$(python -c "import uuid; print str(uuid.uuid4())")
key=$(python -c "import uuid; print str(uuid.uuid4())")
secret=$(python -c "import uuid; print str(uuid.uuid4())")
machine=$(python -c "import uuid; print str(uuid.uuid4())")
ssh-keygen -f $account -N "" -q
publickey=$(cat $account.pub | awk '{print $1,$2}')

cat <<EOI
Make gCloud bucket, upload private key to private-key bucket
gsutil mb -c regional -p $PROJECT_NAME -l us-east1 gs://eureka-account-$account/
gsutil cp $account gs://${PROJECT_NAME}-privatekeys

Insert into accounts (requires adding user details)
INSERT INTO \`accounts\` (\`account_id\`, \`name\`, \`key\`, \`secret\`, \`first_name\`, \`last_name\`, \`email\`, \`spending_quota\`, \`vm_quota\`, \`public_key\`) VALUES ('$account',<customer-company/name>,'$key','$secret',<firstname>,<lastname>,<email>,'100.0',10,'$publickey');

SSH into the machinas machine, and mount cloud storage:
sudo mkdir /mnt/eureka-account-$account
sudo gcsfuse eureka-account-$account /mnt/eureka-account-$account

Still in machinas, run the user docker container:
git clone git@bitbucket.org:alongalky/utility-scripts.git
cd utility-scripts/dockerfiles/numpy
sudo docker build . -t numpy-ssh
sudo docker run -i -t -d -p 3000-4000:22 -v /mnt/eureka-account-$account/:/keep -e "PUBLIC_KEY=$publickey" numpy-ssh

Parse the container and port
container=\$(sudo docker ps | sed -n "2p" | awk '{print \$1}')
port=\$(sudo docker port \$container | sed -rn 's/.+:(.+)\$/\1/p')

Insert the new machine. Requires changing container and port
INSERT INTO \`machines\` (\`machine_id\`, \`name\`, \`account_id\`, \`vm_id\`, \`container_id\`, \`ssh_port\`) VALUES ('$machine', 'machina', '$account', 'machinas-$PROJECT_NAME', '<container-id>', '<port>');

EOI

userconfigfile=$account.eureka.config.yaml
echo "Writing to user config file: $userconfigfile"
echo "key: $key" > $userconfigfile
echo "secret: $secret" >> $userconfigfile
echo "account: $account" >> $userconfigfile
echo "endpoint: https://$PROJECT_NAME.appspot.com" >> $userconfigfile
