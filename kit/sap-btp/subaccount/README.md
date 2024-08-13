# SAP BTP subaccount with environment configuration

This building block Creates a subaccount in SAP BTP.

## How to use this Building Block in meshStack

1. Go to your meshStack admin area and click on "Building Blocks" from the left pane
2. Click on "Create Building Block"
3. Fill out the general information and click next
4. Select any of the platforms as your supported platform to attach this building block to.
5. Select "Terraform" in Implementation Type and put in the Terraform version
6. Copy the repository HTTPS address to the "Git Repository URL" field (if its a private repo, add your SSH key) click next
7. For the inputs do the following
    - Backend configuration:
        - Select "File" as input type and upload the backend.tf file.
        - Add related environment variables based on your backend configuration (e.g. client_id and client_secret for azure, SA_ID and SA_EMAIL for GCS)
    - SAP Account Variables:
        - BTP_USERNAME and BTP_PASSWORD as Environment variable
    - Add rest of the variables in variables.tf as you desired
8. On the next page, add the outputs from outputs.tf file and click on Create Building Block
9. Now users can add this building block to their tenants

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_btp"></a> [btp](#requirement\_btp) | 0.6.0-beta2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [btp_subaccount.subaccount](https://registry.terraform.io/providers/SAP/btp/0.6.0-beta2/docs/resources/subaccount) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_globalaccount"></a> [globalaccount](#input\_globalaccount) | The subdomain of the global account in which you want to manage resources. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The meshStack project identifier. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the subaccount. | `string` | n/a | yes |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | The meshStack workspace identifier. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_btp_subaccount_id"></a> [btp\_subaccount\_id](#output\_btp\_subaccount\_id) | n/a |
| <a name="output_btp_subaccount_name"></a> [btp\_subaccount\_name](#output\_btp\_subaccount\_name) | n/a |
| <a name="output_btp_subaccount_region"></a> [btp\_subaccount\_region](#output\_btp\_subaccount\_region) | n/a |
<!-- END_TF_DOCS -->