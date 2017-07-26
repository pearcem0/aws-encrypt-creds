#!/bin/bash

function encryptcreds(){
if [ -z ${AWS_SHARED_CREDENTIALS_FILE} ]; then
  echo "creds env var not set, using default location"
  type=$(file ~/.aws/credentials | cut -f2 -d' ')
  echo "file type is $type"
  if [ $type = data ]; then
    echo "Already encrypted, nothing to do"
  else
  openssl enc -aes-256-cbc -salt -in ~/.aws/credentials -out ~/.aws/credentials.enc && mv ~/.aws/credentials.enc  ~/.aws/credentials;
  fi
else
  echo ${AWS_SHARED_CREDENTIALS_FILE}
  type=$(file $AWS_SHARED_CREDENTIALS_FILE | cut -f2 -d' ')
  echo "file type is $type"
  if [ $type = data ]; then
    echo "Already encrypted, nothing to do"
  else
  openssl enc -aes-256-cbc -salt -in "$AWS_SHARED_CREDENTIALS_FILE" -out "$AWS_SHARED_CREDENTIALS_FILE".enc && mv "$AWS_SHARED_CREDENTIALS_FILE".enc  "$AWS_SHARED_CREDENTIALS_FILE";
  fi

fi
}

decryptcreds() {
if [ -z ${AWS_SHARED_CREDENTIALS_FILE} ]; then
  echo "creds env var not set, using default location"
  type=$(file ~/.aws/credentials | cut -f2 -d' ')
  echo "file type is $type"
  if [ $type = ASCII ]; then
    echo "Already decrypted, nothing to do"
  else
  openssl enc -aes-256-cbc -d -in ~/.aws/credentials -out ~/.aws/credentials.unenc && mv ~/.aws/credentials.unenc ~/.aws/credentials;
  fi
else
  echo "$AWS_SHARED_CREDENTIALS_FILE"
  type=$(file $AWS_SHARED_CREDENTIALS_FILE | cut -f2 -d' ')
  echo "file type is $type"
  if [ $type = ASCII ]; then
    echo "Already decrypted, nothing to do"
  else
  openssl enc -aes-256-cbc -d -in $AWS_SHARED_CREDENTIALS_FILE -out $AWS_SHARED_CREDENTIALS_FILE.unenc && mv $AWS_SHARED_CREDENTIALS_FILE.unenc $AWS_SHARED_CREDENTIALS_FILE;
  fi
fi
}

if [ "$#" -lt 1 ] ; then
  echo "Please provide a flag (-e or -d)"
fi

while getopts "ed" opt; do
  case $opt in
    e)
      encryptcreds
      ;;
    d)
      decryptcreds
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
