
BRANCH=main
NAME=voting
STAGE=pr-x
TF_WORKSPACE=$(NAME)-$(STAGE)


workspace:
	terraform -chdir=terraform workspace select $(TF_WORKSPACE) || terraform -chdir=terraform workspace new $(TF_WORKSPACE)
apply: workspace
	terraform -chdir=terraform apply -var 'name=voting' -var 'stage=pr-x' -var 'branch=main'


destroy: workspace
	terraform -chdir=terraform destroy -var 'name=voting' -var 'stage=pr-x' -var 'branch=main'