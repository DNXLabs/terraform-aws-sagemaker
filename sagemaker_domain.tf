data "aws_vpc" "selected" {
  id = var.sagemaker_domain_vpc_id
}

resource "aws_sagemaker_domain" "domain" {

  domain_name = var.sagemaker_domain_name
  auth_mode   = var.sagemaker_domain_auth_mode
  vpc_id      = var.sagemaker_domain_vpc_id
  subnet_ids  = var.sagemaker_domain_subnet_ids

  default_user_settings {
    security_groups = [aws_security_group.sagemakerstudio.id]
    execution_role  = aws_iam_role.execution_role.arn
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

resource "aws_security_group" "sagemakerstudio" {
  name        = "sagemakerstudio-${var.sagemaker_domain_name}-sg"
  description = "SG for Sagemaker Studio"
  vpc_id      = var.sagemaker_domain_vpc_id

  tags = {
    Name = "sagemakerstudio-${var.sagemaker_domain_name}-sg"
  }
}

resource "aws_security_group_rule" "SagemakerStudioSG" {
  description       = "Allow all traffic from Sagemaker Studio"
  type              = "ingress"
  protocol          = "ALL"
  to_port           = -1
  from_port         = -1
  security_group_id = aws_security_group.sagemakerstudio.id
}

resource "aws_security_group_rule" "ip_allowlist" {
  description = "NFS traffic over TCP on port 2049 between the domain and the Amazon EFS volume"
  type        = "ingress"
  protocol    = "TCP"
  to_port     = 2049
  from_port   = 2049
  cidr_blocks  = [cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)]
  security_group_id = aws_security_group.sagemakerstudio.id

}

resource "aws_security_group_rule" "egress" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sagemakerstudio.id
  cidr_blocks       = ["0.0.0.0/0"]
}