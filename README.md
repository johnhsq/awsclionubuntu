## Docker image with AWS CLI on Ubuntu
This repository contains **Dockerfile** of [AWS CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html) for Docker published to the public [Docker Hub](https://hub.docker.com/r/johnhsq/awsclionubuntu/).


### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)


### Build

	docker build -f Dockerfile -t johnhsq/awsclionubuntu .

### Usage
In your local linux add the following command alias to your profile (e.g. ~/.bash_profile)

     alias awscli.test="docker run \
       -it \
       -v $(pwd):/data \
       --env AWS_ACCESS_KEY_ID= <your aws access key> \
       --env AWS_SECRET_ACCESS_KEY= <your aws secret key> \
       --env AWS_DEFAULT_REGION= <your aws default region> \
       johnhsq/awsclionubuntu /bin/sh"

### Test
Start AWS CLI

     $ awscli.test

Test your AWS environment with the following commands

     # python3 --version
     # curl --version
     # jq --version
     # aws --version
     # aws iam list-account-aliases
     # aws ec2 describe-instances


## Useful AWS CLI Scripts
#### Describe EC2 instances from all regions

	for region in `aws ec2 describe-regions --output text | cut -f3`
	do
	     echo -e "\nListing Instances in region:'$region'..."
	     aws ec2 describe-instances --region $region | jq '.Reservations[] | ( .Instances[] | {state: .State.Name, name: .KeyName, type: .InstanceType, key: .KeyName})'
	done

#### Create/Describe/Delete an EC2 instance

    aws ec2 run-instances --image-id ami-824c4ee2 --count 1 --instance-type t2.micro --user-data file://userdata.txt --security-group-ids sg-73d2960a --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=JohnTestWebServer},{Key=CreatedBy,Value=JohnH},{Key=CreatedDate,Value=3/11/18}]'

    aws ec2 describe-instances
  
    aws ec2 describe-instances --filters "Name=tag:Name,Values=JohnTestWebServer" | grep -i instanceid
  
    aws ec2 terminate-instances --instance-ids <value>
	
#### Create/Describe/Delete Database
    
    aws rds create-db-instance \
        --db-instance-identifier <value> \
        --db-instance-class db.t2.micro \
        --engine MySQL \
        --allocated-storage 20 \
        --master-username admin \
        --master-user-password admin1234 \
        --backup-retention-period 7

    aws rds describe-db-instances

    aws rds describe-db-instances --db-instance-identifier <value>

    aws rds describe-db-instances --db-instance-identifier <value> | grep -i status

    aws rds delete-db-instance --db-instance-identifier <value> --no-skip-final-snapshot --final-db-snapshot-identifier <value>



