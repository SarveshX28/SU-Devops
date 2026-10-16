# Unit 4 — Infrastructure Automation
**Prepared for:** Sarvesh Nage

Starter project based on the uploaded Unit 4 lab guide (AWS CLI v2, Terraform, Ansible).

## Project structure
- `scripts/install-tools-ubuntu.sh` — installs AWS CLI v2, Terraform, and Ansible on Ubuntu.
- `scripts/verify-tools.sh` — checks installed tools and AWS authentication.
- `terraform/` — example Terraform configuration for a VPC, subnet, internet gateway, route table, security group, and Ubuntu EC2 instance.
- `ansible/` — example playbook to install Docker and Nginx on the target host.
- `.gitignore` — excludes Terraform state, SSH keys, and local secrets.

## Safety first
1. Use an AWS account/role you are authorized to use.
2. Configure credentials using an approved AWS method (`aws configure` for a lab IAM user, or an AWS role/profile). Never commit credentials.
3. Terraform resources may incur charges. Review `terraform plan` before applying, and run `terraform destroy` when finished if you no longer need them.
4. SSH is restricted to the CIDR you provide in `terraform.tfvars`. Set it to your current public IP with `/32`; do not use `0.0.0.0/0`.
5. This is a starter configuration, not proof that AWS resources have been created.

## 1. Install tools (Ubuntu 22.04 / WSL2 Ubuntu)
```bash
chmod +x scripts/*.sh
./scripts/install-tools-ubuntu.sh
```
The script adds the official HashiCorp APT repository and installs AWS CLI v2, Terraform, and Ansible. Check the official vendor documentation if repository URLs or package steps change.

## 2. Configure AWS credentials
```bash
aws configure
aws sts get-caller-identity
```
Enter your own credentials locally. Do not paste keys into this README, source files, or GitHub.

## 3. Configure Terraform
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars` and set `ssh_allowed_cidr` to your current public IP followed by `/32`, e.g. `203.0.113.10/32` (replace this documentation example).
Then:
```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```
Inspect the plan carefully. Only if you understand and approve the resources and costs:
```bash
terraform apply
```
To remove lab resources after you finish:
```bash
terraform destroy
```

## 4. Configure Ansible after EC2 is provisioned
Copy the public IP from Terraform output:
```bash
cd ../ansible
cp inventory.ini.example inventory.ini
```
Edit `inventory.ini` with the actual public IP and path to your existing private key file. Then run:
```bash
ansible -i inventory.ini all -m ping
ansible-playbook -i inventory.ini site.yml
```
The example playbook installs Docker Engine and Nginx. It does not deploy the Student Management app; app deployment can be added after the base server configuration works.

## Verification
```bash
aws --version
terraform -version
ansible --version
aws sts get-caller-identity
```
Successful verification depends on your own machine, network, AWS account permissions, and credentials.
