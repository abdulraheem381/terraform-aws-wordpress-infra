
# Terraform AWS WordPress Infrastructure

## 📌 Project Overview
This project provisions a **WordPress application** on AWS using Terraform.  
It creates:
- VPC with public/private subnets
- EC2 instance with Apache/PHP/WordPress (via user_data)
- RDS MySQL instance
- Security Groups (EC2 → RDS, HTTP/SSH access)

## 🚀 How to Deploy
1. Clone this repo:
   ```bash
   git clone https://github.com/your-username/terraform-aws-wordpress-infra.git
   cd terraform-aws-wordpress-infra
   


2. Initialize Terraform:

   ```bash
   terraform init
   ```
3. Plan the infrastructure:

   ```bash
   terraform plan
   ```
4. Apply changes:

   ```bash
   terraform apply -auto-approve
   ```

## 🔧 Variables

See `variables.tf` for configurable parameters (region, instance\_type, DB username/password, etc.).

## 📊 Outputs

After apply, Terraform will output:

* WordPress Public IP
* RDS Endpoint

## ⚠️ Cleanup

To destroy the infra:

```bash
terraform destroy -auto-approve
```


## 📂 Repo Structure

```bash

terraform-aws-wordpress-infra/
│── README.md                  # Project documentation
│── main.tf                    # Main Terraform config
│── variables.tf               # Input variables
│── outputs.tf                 # Outputs (public IP, DB endpoint, etc.)
│── providers.tf               # Provider + region config
│── terraform.tfvars           # Actual variable values (gitignore this if sensitive)
│
├── modules/                   # Reusable modules
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf            # EC2 instance + user_data (WordPress install)
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── rds/
│   │   ├── main.tf            # MySQL RDS instance
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── security-groups/
│       ├── main.tf            # SG for EC2 + RDS
│       ├── variables.tf
│       └── outputs.tf
│
└── .gitignore                 # Ignore .terraform/, tfstate, tfvars)
```

## 📰 Blog Post
I documented this project in detail on my Hashnode blog:  
👉 [Read the full article here](https://your-hashnode-link.com)

## 🐦 Twitter/X Post
I also shared my learnings and project highlights on X (Twitter):  
👉 [Check the post here](https://x.com/Abdulraheem183)

