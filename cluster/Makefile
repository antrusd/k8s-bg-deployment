PROJECT_ID       = antrusd-project-id

CLUSTER_NAME     = antrusd-gke-01
CLUSTER_VERSION  = 1.13.12-gke.13
VPC_NAME         = antrusd-personal-vpc
SUBNET_NAME      = antrusd-personal-subnet

WORKER_SPEC      = g1-small
WORKER_DISK      = 60
WORKER_COUNT     = 1


all: init plan apply

init:
	terraform init

plan: init
	terraform plan  -input=false -out terraform.plan \
			-var project=${PROJECT_ID} \
			-var cluster_name=${CLUSTER_NAME} \
			-var cluster_version=${CLUSTER_VERSION} \
			-var worker_spec=${WORKER_SPEC} \
			-var worker_disk=${WORKER_DISK} \
			-var worker_count=${WORKER_COUNT} \
			-var vpc=${VPC_NAME} \
			-var subnet=${SUBNET_NAME}

apply: plan
	terraform apply -input=false terraform.plan

refresh: init
	terraform refresh -input=false

destroy: init refresh *.tfstate
	terraform destroy -input=false -auto-approve && rm -f *.tfstate *.tfstate.backup
	make clean

clean:
	rm -f *.plan kubeconfig
