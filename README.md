# aws-encrypt-creds

# about aws-encrypt-creds
* A experimental way of encrypting awscli credentials while not in use, and decrypt as needed
* Checks if there is an env var set for a shared credentials file, if not uses default location
* Checks file type to avoid encrypting/decrypting files unnecessarily

# prerequisites & assumptions
* You have installed and configured awscli (used for describe-instances api calls etc.)
* Required ssh keys are held at ~/.ssh/ or set with the env var AWS_SHARED_CREDENTIALS_FILE
* you have openssl installed

# usage
* `aws-encrypt-creds -e` to encrypt
* `aws-encrypt-creds -d` to decrypt

# further usage
* You may choose to run the script as part of your shell aliases so that you don't have to type the same parameters each time
* e.g. `function aws (){
/usr/local/bin/aws-encrypt-creds.sh -d
/usr/local/bin/aws "$@"
/usr/local/bin/aws-encrypt-creds.sh -e
}`

# disclaimer
* For personal use and development - may not work for you, but feel free adapt as necessary

# Ideas
* Integrate with awscli - either using bash alias or editing awscli source
* Is there anyway to run this headless? Currently requires user intervention for password input
* If run without flags either encrypt or decrypt based on current file format
