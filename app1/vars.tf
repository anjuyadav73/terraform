## Provider varibales account-id and role-id ##
variable "account-id" {
  default     = "584252575254"
  type        = string
  description = "Provide the AWS account ID where the resources are goting to deploy."
}

variable "role-id" {
  default     = "admin"
  type        = string
  description = "Provide the AWS role ID which having the required permission for the resources to be deployed."
}

