resource "aws_sagemaker_user_profile" "sagemaker_user_profile" {

  user_profile_name = "datascientist"
  domain_id         = aws_sagemaker_domain.domain.id
  #single_sign_on_user_value = var.sagemaker_user_profile_single_sign_on_user_value

  #single_sign_on_user_identifier = var.sagemaker_user_profile_single_sign_on_user_identifier

  user_settings {
    execution_role = aws_iam_role.execution_role.arn

    security_groups = [aws_security_group.sagemakerstudio.id]
  }
}