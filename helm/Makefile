all: init plan apply

init:
	terraform init

plan: init
	terraform plan  -input=false -out terraform.plan

apply: plan
	terraform apply -input=false terraform.plan

refresh: init
	terraform refresh -input=false

destroy: init refresh *.tfstate
	terraform destroy -input=false -auto-approve && rm -f *.tfstate *.tfstate.backup
	make clean

clean:
	rm -f *.plan
