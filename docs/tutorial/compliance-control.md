# Create a Compliance Control

> Note: this section of the documentation is under constrution

To document how your landing zones help implement compliance, follow this workflow

```shell
collie compliance new "data-privacy/eu-only" # create a new compliance control
vi kit/aws/organization-policies/README.md   # add a compliance statement to your aws organization-policies module
collie compliance tree                       # review compliance control implementation across platforms
collie docs "my-foundation"                  # generate a documentation site for your cloud foundation, incl. compliance info
```
