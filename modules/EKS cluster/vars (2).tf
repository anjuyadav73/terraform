##############################################################################
#                          Variables                                         #
##############################################################################
## EC2 Configuration Variables ##
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

variable "instance-name" {
  description = "Please enter the name of the EC2 Instance."
  type        = string
}

variable "instance-type" {
  description = "Please provide the EC2 Instance type."
  type        = string
  default     = "t2.micro"
}

variable "instance-count" {
  description = "Please provide the number of instances to be created."
  type        = string
  default     = "1"
}

variable "iam-instance-profile" {
  description = "The name of the instance profile to apply to the instance. The DefaultSSMInstanceProfile is applied if nothing else is chosen."
  type        = string
  default     = "DefaultSSMInstanceProfile"
}

variable "cf-stack-output-name" {
  type        = string
  default     = "SSMInstanceProfile"
  description = "Provide the CloudFormation Stack output name to export it's value in terraform module."
}

variable "latest-ami-id" {
  type        = string
  default     = "/GoldenAMI/RHEL-7/CISRHEL7Benchmark-1/latest"
  description = "SSM path for latest Linux Golden AMI ImageId"
}

variable "user-data" {
  type        = string
  default     = ""
  description = "Base64 encoded SSM installation user-data."
}

variable "subnet-id" {
  type        = string
  description = "Please provide which subnet this EC2 will be deployed in."
}

variable "vpc-security-group-ids" {
  type        = list(string)
  description = "Please provide which security group(s) this EC2 will use."
}

variable "availability-zone" {
  type        = string
  description = "Provide an AZ if you have an application level requirement"
  default     = ""

  validation {
    condition     = contains(["", "ca-central-1a", "ca-central-1b"], var.availability-zone)
    error_message = "Argument \"availability-zone\" must be \"ca-central-1a\" or \"ca-central-1b\"."
  }
}

## Elastic Block Store variables ##

variable "create-ebs-volume" {
  description = "Enables the creation of an EBS Volume for the EC2 Instance."
  type        = string
  default     = "false"

  validation {
    condition     = contains(["true", "false"], var.create-ebs-volume)
    error_message = "Argument \"create-ebs-volume\" must be \"true\" or \"false\"."
  }
}

variable "ebs-volume-size" {
  type        = string
  description = "Enter the size of the EBS Volume."
  default     = "1"
}

variable "ebs-volume-type" {
  type        = string
  description = "Enter the type of the EBS Volume."
  default     = "gp2"
}



#### Taging variables ####

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
    condition     = contains(["sandbox", "qa", "dev", "ss", "rss", "staging", "prd"], var.environment)
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

variable "otl-value" {
  default     = "123456"
  type        = string
  description = "Please enter the OTL tag value."

  validation {
    condition     = can(regex("^[0-9]{6}$", var.otl-value))
    error_message = "Please enter the valid 6 digit otl-value."
  }
}

variable "task-code-value" {
  default     = ""
  type        = string
  description = "Please enter the OTL TaskCode tag value."
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