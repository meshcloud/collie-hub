---
name: Foundation Docs Template
summary: |
  This module generates a vuepress documentation site scaffolding for this cloudfoundation.
compliance:
  - control: cfmm/security-and-compliance/shared-responsibility-model-alignment
    statement: |
      The documentation informs application teams, security auditors and other stakeholders about the landing zones
      offered by the cloud foundation team. It provides detailed descriptions of responsibilities to be carried
      by each party and lists points of contacts for all stakeholders.
---

# Foundation Docs Template

This documentation is intended as a reference documentation for cloud foundation or platform engineers using this module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.module_docs](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/resources/file) | resource |
| [local_file.platform_readmes](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/resources/file) | resource |
| [null_resource.copy_compliance](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [null_resource.copy_template](https://registry.terraform.io/providers/hashicorp/null/3.2.2/docs/resources/resource) | resource |
| [terraform_remote_state.docs_azure](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_foundation_dir"></a> [foundation\_dir](#input\_foundation\_dir) | path to the collie foundation directory for this foundation | `string` | n/a | yes |
| <a name="input_output_dir"></a> [output\_dir](#input\_output\_dir) | path to the directory where to store the generated documentation output | `string` | n/a | yes |
| <a name="input_platforms"></a> [platforms](#input\_platforms) | platform configuration required to produce docs | <pre>object({<br>    azure = object({<br>      aad_tenant_id   = string<br>      subscription_id = string<br>      tfstateconfig = object({<br>        resource_group_name  = string<br>        storage_account_name = string<br>        container_name       = string<br>      })<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_repo_dir"></a> [repo\_dir](#input\_repo\_dir) | path to the collie repository directory | `string` | n/a | yes |
| <a name="input_template_dir"></a> [template\_dir](#input\_template\_dir) | path to the directory containing the docs site template | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->