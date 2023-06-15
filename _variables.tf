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

variable "app_network_access_type" {
  type        = string
  default     = "PublicInternetOnly"
  description = "Specifies the VPC used for non-EFS traffic. The default value is PublicInternetOnly. Valid values are PublicInternetOnly and VpcOnly."
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "The AWS KMS customer managed CMK used to encrypt the EFS volume attached to the domain."
}