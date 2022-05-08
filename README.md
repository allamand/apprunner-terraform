# Apprunner Preview Branch with Terraform


Bucker name must be created in advance:

S3_BUCKET_NAME=sallaman-s3-reviewapps-terraform-state-files; aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $AWS_REGION --create-bucket-configuration LocationConstraint=$AWS_REGION
