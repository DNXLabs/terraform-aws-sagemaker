resource "aws_sagemaker_domain" "domain" {

  domain_name = var.sagemaker_domain_name 
  auth_mode   = var.sagemaker_domain_auth_mode
  vpc_id      = var.sagemaker_domain_vpc_id
  subnet_ids  = var.sagemaker_domain_subnet_ids

  default_user_settings {
    execution_role = aws_iam_role.execution_role.arn
  }
}

resource "aws_iam_role" "execution_role" {
  name               = "sagemaker_execution_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.execution_role_policy.json
}

data "aws_iam_policy_document" "execution_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
  }
}