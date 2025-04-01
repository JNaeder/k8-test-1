# Steps for Running Locally

- ## Frontend
  - `cd` into the `./frontend` folder
  - Run `npm install` to install all the dependices
  - Run `npm run dev` to run the development server
- ## Backend
  - `cd` into the `./backend` folder
  - Create a Python virtual environment with `python -m venv venv`
  - Start the virtual environment with `./venv/Scripts/activate`
  - Run `pip install -r requirements.txt` to install the dependices
  - Run `uvicorn main:app --reload` to run the development server

# Steps for Building to Production

_I still have to automate all of this_

- ## Create cloud resources
  - ### Setup the terraform variables
    - Create a `terraform.tfvars` file in `/terraform`
    - Set the following variables
      - **project_id**
      - **region**
      - **zone**
      - **external_ip** (will have to set this later after the Ingress Service is created)
      - **domain_name**
  - ### Run the Terraform commands
    - `terraform init`
    - check with `terraform plan`
    - `terraform apply -auto-approve`
- ## Build and push container
  - Run the `./scripts/build_containers.sh` file
  - Grab the tag of the new containers
  - Add the tag to the `./kubernetes/deployments.yaml` file
    - Add it to both the frontend and backend images
- ## Deploy Kubernetes
  - Make sure to have the follow SSL certs in the root folder
    - `certificate.crt`
    - `private.key`
  - Run the `./scripts/deploy_k8.sh` file
  - Once the Ingress service finishes, grab the external IP
  - Add that IP to the **external_ip** variable in the `terraform.tfvars` file
  - Run `terraform apply -auto-approve` again
