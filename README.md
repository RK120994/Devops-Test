##  Overview
This project demonstrates a **secure microservices architecture on AWS** using Terraform.

The goal was to design a **three-tier environment** with strong security, proper network segmentation, and scalable components.

##  Architecture Summary

The infrastructure is divided into three layers:

* **Public Layer**

  * API Gateway (public access)
  * NAT Gateway (for controlled internet access)

* **Private Layer (with internet egress)**

  * Lambda function
  * Can access the internet through NAT Gateway

* **Isolated Layer (no internet access)**

  * Lambda function for sensitive data processing
  * Private API communication only
  * Stores data in S3 securely

##  Application Flow

1. Client sends request to Public API Gateway
2. Public API triggers Lambda (Private Subnet)
3. Private Lambda calls internal API (Private API Gateway)
4. Request goes to Isolated Lambda (no internet access)
5. Isolated Lambda processes sensitive data and stores it in S3
6. Response flows back to client

## Security Design

* Network segmentation using **Public, Private, and Isolated subnets**
* **No internet access** from isolated subnet
* **NAT Gateway** for controlled outbound access
* **IAM roles** with least privilege
* **S3 encryption enabled**
* **VPC Endpoint** used for private S3 access
* **WAF** added for API protection (basic setup)

## Technologies Used

* AWS (VPC, Lambda, API Gateway, S3, WAF)
* Terraform (Infrastructure as Code)
* Python (Lambda functions)

## How to Run

# Configure AWS Credentials

Before running Terraform, configure your AWS account using the AWS CLI:
aws configure
Enter the following details:
* AWS Access Key ID
* AWS Secret Access Key
* Default region (`us-east-1`)
* Output format (Json)

# Initialize Terraform
terraform init

# Review Execution Plan
terraform plan

 **Note:**
I did not run `terraform apply` to avoid AWS usage charges.
Screenshots of `terraform init` and `terraform plan` are included in this repository.

## Screenshots
Screenshots are provided for:
* Terraform Initialization (`terraform init`)
* Terraform Plan (`terraform plan`)

## Improvements (Future Scope)
If given more time, I would:
* Add CloudWatch logging and monitoring
* Implement CI/CD pipeline
* Use Secrets Manager for secure credentials
* Improve WAF integration using CloudFront or ALB
* Add multi-AZ high availability
* 
## Conclusion
This project demonstrates:
* Secure infrastructure design
* Proper network isolation
* Scalable serverless architecture
* Terraform best practices
