variable "sagemaker_domain_name" {
  description = "Name for Sagemaker Studio Domain"
}

variable "sagemaker_domain_auth_mode" {
  default     = "IAM"
  description = "Authentication Mode for Sagemaker Studio Domain. Valid values are IAM and SSO"
}

variable "sagemaker_domain_vpc_id" {
  description = "The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication."
}

variable "sagemaker_domain_subnet_ids" {
  type        = list(string)
  description = "The VPC subnets that Studio uses for communication"
}