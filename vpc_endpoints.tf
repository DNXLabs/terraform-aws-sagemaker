data "aws_vpc" "selected" {
  id = var.sagemaker_domain_vpc_id
}

resource "aws_vpc_endpoint" "sagemaker_api" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.sagemaker.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ptfe_service.id,
  ]

  subnet_ids          = [var.subnet_ids]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "sagemaker_runtime" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.sagemaker.runtime"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ptfe_service.id,
  ]

  subnet_ids          = [var.subnet_ids]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ptfe_service.id,
  ]

  subnet_ids          = [var.subnet_ids]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

resource "aws_security_group" "vpcendpoint" {
  name        = "vpcendpoint-${var.name}-sg"
  description = "SG for VPC Endpoints from Sagemaker Studio"
  vpc_id      = var.vpc_id

  tags = {
    Name = "vpcendpoint-${var.name}-sg"
  }
}

resource "aws_security_group_rule" "fromvpcendpoint" {
  description       = "Allow all traffic"
  type              = "ingress"
  protocol          = "ALL"
  to_port           = -1
  from_port         = -1
  security_group_id = aws_security_group.vpcendpoint.id
}

resource "aws_security_group_rule" "fromsagemaker" {
  description       = "Allow all traffic from Sagemaker"
  type              = "ingress"
  protocol          = "ALL"
  to_port           = -1
  from_port         = -1
  security_group_id = aws_security_group.sagemakerstudio.id
}

resource "aws_security_group_rule" "fromvpc" {
  description = "Allow all traffic within VPC"
  type        = "ingress"
  protocol    = "ALL"
  to_port     = -1
  from_port   = -1
  cidr_block  = cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)
}

resource "aws_security_group_rule" "egress" {
  description       = "Traffic to internet"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.vpcendpoint.id
  cidr_blocks       = ["0.0.0.0/0"]
}