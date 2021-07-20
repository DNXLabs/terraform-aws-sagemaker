output "sagemaker_role_arn" {
  value = aws_iam_role.execution_role.arn
}

output "sagemaker_role_name" {
  value = aws_iam_role.execution_role.id
}

output "sagemaker_security_group" {
  value = aws_security_group.sagemakerstudio.id
}