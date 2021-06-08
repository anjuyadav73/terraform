##############################################################################
#                          Variables                                         #
##############################################################################
# Account ID and Role ID Variables #

variable "account-id" {
  default     = ""
  type        = string
  description = "Provide the AWS account ID where the resources are goting to deploy."
}

variable "role-id" {
  default     = ""
  type        = string
  description = "Provide the AWS role ID which having the required permission for the resources to be deployed."
}

# EKS module Variables #

variable "clustername" {
  default     = ""
  type        = string
  description = "Name of the EKS cluster"
}

variable "vpcid" {
  default     = ""
  type        = string
  description = "VPC where the cluster and workers will be deployed"
}

variable "vpc-cidr" {
  default     = ""
  type        = string
  description = "The CIDR block for the VPC"
}

variable "privatesubnet1" {
  default     = ""
  type        = string
  description = "Subnet ID to place the EKS cluster and workers within"
}

variable "privatesubnet2" {
  default     = ""
  type        = string
  description = "Subnet ID to place the EKS cluster and workers within"
}

variable "ec2keypair" {
  default     = ""
  type        = string
  description = "Name of the EC2 Keypair for EC2 instances in Managed Node Group"
}

variable "scaling-desired-size" {
  default     = "2"
  type        = string
  description = "EC2 Instances desired size for auto scaling group"
}
variable "scaling-max-size" {
  default     = "2"
  type        = string
  description = "EC2 instances max size for auto scaling group"
}
variable "scaling-min-size" {
  default     = "2"
  type        = string
  description = "EC2 Instances min size for auto scaling group"
}
variable "eks-version" {
  default     = "1.17"
  type        = string
  description = "EKS version to be used for EKS deployment"
}

variable "ami-release-version" {
  default     = "1.17.9-20200814"
  type        = string
  description = "AMI release version to be used by EC2 instances in managed node group"
}

variable "aws-account-id" {
  default     = ""
  type        = string
  description = "AWS Account to be used for EKS deployment"
}

###### Tagging Variables ######

## Tagging Variables ####


variable "TFE" {
  default = "YES"
  type    = string

  validation {
    condition     = contains(["YES"], var.TFE)
    error_message = "Argument \"TFE\" must be \"YES\"."
  }
}

variable "data-classification" {
  default     = "restricted"
  type        = string
  description = "Please specify the DataClassification type"

  validation {
    condition     = contains(["restricted", "confidential", "internal", "public"], var.data-classification)
    error_message = "Argument \"data-classification\" must be \"restricted\" or \"confidential\" or \"internal\" or \"public\" ."
  }
}

variable "environment" {
  default     = ""
  type        = string
  description = "Please enter the Environment type"

  validation {
    condition     = contains(["sandbox", "qa", "dev", "ss", "rss", "staging", "prd", "dscworkstation", "dscproduction"], var.environment)
    error_message = "Argument \"environment\" must be one of \"sandbox\", \"qa\", \"ss\", \"rss\", \"staging\",  \"prd\", \"dscworkstation\", \"dscproduction\" ."
  }
}

variable "application-id" {
  default     = "1234"
  type        = string
  description = "Please enter the Application ID"

  validation {
    condition     = can(regex("^[0-9]{4}$", var.application-id))
    error_message = "Please enter the valid application-id."
  }
}

variable "application-owner" {
  default     = ""
  type        = string
  description = "Please enter Email ID of the owner or domain/username or service account"
}

variable "application-role" {
  default     = ""
  type        = string
  description = "Please enter the Application Role"

  validation {
    condition     = contains(["database", "web", "app"], var.application-role)
    error_message = "Argument \"application-role\" must be \"database\" or \"web\" or \"app\"."
  }
}

variable "SCOA" {
  default     = "123.1234.1234.1234.12345"
  type        = string
  description = "Please enter the SCOA"

  validation {
    condition     = can(regex("^[0-9]{3}[.][0-9]{4}[.][0-9]{4}[.][0-9]{4}[.][0-9]{5}$", var.SCOA))
    error_message = "Please enter the valid SCOA ID."
  }
}

variable "project-id" {
  default     = "123456"
  type        = string
  description = "Please enter the ProjectID ID"

  validation {
    condition     = can(regex("^[0-9]{6}$", var.project-id))
    error_message = "Please enter the valid 6 digit project-id."
  }
}

variable "PII" {
  default = "NO"
  type    = string

  validation {
    condition     = contains(["NO", "YES"], var.PII)
    error_message = "Argument \"PII\" must be \"NO\" or \"YES\"."
  }
}

variable "compliance" {
  default = "None"
  type    = string

  validation {
    condition     = contains(["None", "PCI", "SOX", "SOX and PCI"], var.compliance)
    error_message = "Argument \"compliance\" must be \"None\" or \"PCI\" or \"SOX\" or \"SOX and PCI\"."
  }
}

variable "businessunit" {
  default     = ""
  type        = string
  description = "Provide the businessunit Name"
}

variable "application-name" {
  default     = ""
  type        = string
  description = "Please enter Application Name"
}
