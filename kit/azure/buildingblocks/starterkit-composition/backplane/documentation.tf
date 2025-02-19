output "documentation_md" {
  value = <<EOF
# Starter Kit Building Block

The Likvid Bank DevOps Toolchain team maintains a set of starter kits to help application teams get started
on the cloud quickly.

"Cloud Starter Kits" provide application teams with

- a GitHub repository, seeded with an application starter kit
- a GitHub actions pipeline
- an Azure Managed Identity that enables the GitHub actions pipeline to deploy to your Azure Subscription

## How to work with a Starter Kit

> Starter Kits are meant to be used in [Sandbox Landing Zones](./azure-landingzones-sandbox.md) for learning and experimentation only.

The easiest way to get started with a Starter Kit is to search for "Starter Kit" in the Likvid Bank Cloud Portal
Marketplace and let the portal help you add it to a Sandbox Subscription (or create a new one if you don't have one yet).

Starter Kits will create a (private) GitHub repository for you in our [GitHub Organization](https://github.com/${var.github_org}).
You will find the URL for your repository in the Starter Kit building block output tab. Please review the `README.md`
of that repository for further instructions and inspiration for working with the starter kit.

## Next Steps when using a Starter Kit

Once you are happy with your results, please provision a [Cloud-Native Landing Zone](./azure-landingzones-cloud-native.md) and fork-and-own the
starter kit template, including the infrastructure set up by the starter kit building block. We recommend this policy,
because for productive use cases you will eventually need to customize the way your CI/CD pipeline interacts with the
cloud. See [Secure DevOps Best Practices](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/secure/best-practices/secure-devops)
for a good overview of securing production pipelines.

## Automation

This building block uses its own dedicated service principal `${azuread_application.starterkit.display_name}` to automate deployment
of required resources to your Azure subscription.

EOF
}
