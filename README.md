# terraform-aws-sagemaker

[![Lint Status](https://github.com/DNXLabs/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/DNXLabs/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/DNXLabs/terraform-aws-template)](https://github.com/DNXLabs/terraform-aws-template/blob/master/LICENSE)

<!--- BEGIN_TF_DOCS --->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sagemaker\_domain\_auth\_mode | Authentication Mode for Sagemaker Studio Domain. Valid values are IAM and SSO | `string` | `"IAM"` | no |
| sagemaker\_domain\_name | Name for Sagemaker Studio Domain | `any` | n/a | yes |
| sagemaker\_domain\_subnet\_ids | The VPC subnets that Studio uses for communication | `list(string)` | n/a | yes |
| sagemaker\_domain\_vpc\_id | The ID of the Amazon Virtual Private Cloud (VPC) that Studio uses for communication. | `any` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

## Authors

Module managed by [DNX Solutions](https://github.com/DNXLabs).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/DNXLabs/terraform-aws-sagemaker/blob/master/LICENSE) for full details.
