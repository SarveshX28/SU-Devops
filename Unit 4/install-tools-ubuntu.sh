#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script supports Ubuntu/Debian with apt-get. Use vendor instructions for other OSes."
  exit 1
fi

sudo apt-get update
sudo apt-get install -y ca-certificates curl wget unzip jq gnupg lsb-release software-properties-common python3 python3-pip python3-venv

# AWS CLI v2 official bundle (x86_64; use AWS official instructions for ARM64 machines)
arch="$(uname -m)"
case "$arch" in
  x86_64)
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
    ;;
  aarch64|arm64)
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o /tmp/awscliv2.zip
    ;;
  *)
    echo "Unsupported architecture: $arch"
    exit 1
    ;;
esac
rm -rf /tmp/aws /tmp/awscliv2
unzip -q /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install --update
rm -rf /tmp/aws /tmp/awscliv2.zip

# Terraform official HashiCorp APT repository
wget -qO- https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor --yes -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(. /etc/os-release && echo "$VERSION_CODENAME") main" \
  | sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
sudo apt-get update
sudo apt-get install -y terraform ansible

echo
echo "Installed versions:"
aws --version
terraform -version
ansible --version | head -n 2
