# Foundation

A foundation is made from platforms. This enables a cloud foundation team to manage separate environments, e.g. a
production and development environment that use different AWS Root Accounts, GCP Organizations etc.

## Platform Configurations

A cloud platform configuration object in a construction kit repository needs to match this glob pattern:

```text
foundations/*/platforms/*/README.md
```

Platform configurations are stored as yaml frontmatter in these files. This section documents the mandatory and optional
configuration properties for each type of cloud platform. Note that you can include additional keys in your
configuration to capture data that's useful for automation.

### Common Settings

Settings under the `cli` key will be used by `collie` to set environment variables when invoking the underlying
cloud cli tools. These environment variables will be set verbatim, so please consult the documentation of the respective
cli tool for the configuration possibilities.

Note that many terraform providers (e.g. `azurerm` or `google`) support using the credentials managed by their respective
cloud cli tools. This is especially useful for bootstrapping landing zone deployment.

```yaml
cli:
  aws:     # environment used ot invoke the aws cli tool
  az:      # environment used ot invoke the az cli tool
  gcloud:  # environment used ot invoke the az cli tool
```

### AWS

```markdown
---
aws:
  accountId: "123456789012"                          # required                     
  accountAccessRole: "OrganizationAccountAccessRole" # required                     
cli:
  aws:
    AWS_PROFILE: default                      # required
    AWS_CONFIG_FILE: ./credentials/bootstrap  # optional 
---
```

### Azure

```markdown
---
azure:
  aadTenantId: 00000000-0000-0000-0000-000000000000    # required
  subscriptionId: 00000000-0000-0000-0000-000000000000 # required
cli:
  az:
    AZURE_CONFIG_DIR: ./az # optional
---
```

### GCP

```markdown
---
gcp:
  organization: "1234567890" # required
  project: foundation-12345  # required
  billingExport:             # optional, required for collie tenant cost functionalits
    project: billing-data-1234
    dataset: billing_export
    view: collie_billing_view
cli:
  gcloud:
    CLOUDSDK_ACTIVE_CONFIG_NAME: default # required
---
```
