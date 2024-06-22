echo "BUILD_ENV: cow"

SSH_KEY_FILE=./keynode.pem

rm -f $SSH_KEY_FILE
# Cat ssh key from Jenkins Credentials to ssh key file
cat $SERVER_SSH_KEY_FILE > $SSH_KEY_FILE
chmod 400 $SSH_KEY_FILE

ssh -i $SERVER_SSH_KEY_FILE -o StrictHostKeyChecking=no ubuntu@ec2-3-1-6-106.ap-southeast-1.compute.amazonaws.com '
  cd cicd
  git pull
  cd ../
  export PATH="$PATH:/home/ubuntu/.nvm/versions/node/v20.14.0/bin"
  export PATH="$PATH:/.nvm/versions/node/v20.14.0/bin"
  pm2 restart server
'