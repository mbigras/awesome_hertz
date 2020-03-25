export CGO_ENABLED=0
export PORT=3000

all: build

build:
	go fmt
	go build

clean:
	go clean

run:
	go fmt
	go run main.go

dockerbuild:
	docker build --tag awesome_hertz .

dockerrun:
	docker run --env=PORT=$$PORT --publish=$$PORT:$$PORT awesome_hertz

cloudbuild: clean
	gcloud builds submit --tag gcr.io/playfulpanda/awesome_hertz

deps:		# install dependencies for demo
	brew install terraform go
	brew cask install docker google-cloud-sdk

init:		# initialize gcloud and terraform plugins
	gcloud auth application-default login
	# Enable the run.googleapis.com API while initializing with make init
	# instead of using the google_project_service terraform resource
	# to prevent destroying it, when running make destroy
	# See this issue for more details:
	# https://github.com/hashicorp/terraform/issues/2253
	gcloud services enable run.googleapis.com
	gcloud services enable cloudbuild.googleapis.com
	terraform init

plan:		# create terraform plan in current.plan file
	terraform fmt
	terraform plan -out=current.plan
	@echo "You can also use make, run the following command to apply:"
	@echo "    make apply"

apply:		# apply terraform plan in current.plan file
	terraform apply current.plan

show:		# print terraform state and outputs
	terraform show -no-color

output:		# print terraform outputs
	terraform output

list:		# print GCP cloud run services
	gcloud run services list --platform=managed

destroy:		# create terraform plan to destroy resources (apply plan afterwards)
	terraform plan -destroy -out=current.plan
	@echo "You can also use make, run the following command to apply:"
	@echo "    make apply"
