#!/usr/bin/env bash
set -u
echo "=== AWS CLI ==="
aws --version || true
echo
echo "=== Terraform ==="
terraform -version || true
echo
echo "=== Ansible ==="
ansible --version | head -n 2 || true
echo
echo "=== AWS caller identity (requires configured credentials) ==="
aws sts get-caller-identity || echo "AWS authentication check failed; run aws configure or use your approved AWS role/profile."
