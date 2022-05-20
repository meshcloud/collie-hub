# Create a kit module

> Note: this section of the documentation is under constrution

To build landing zones with collie, follow this workflow

```shell
collie kit new "aws/organization-policies"   # generate a new IaC module skeleton
collie kit apply "aws/organization-policies" # apply the module to a cloud platform in your foundation
collie foundation deploy "my-foundation"     # deploy the module to your cloud foundation
```