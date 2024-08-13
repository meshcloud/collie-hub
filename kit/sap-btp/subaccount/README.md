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

## Backend configuration

Here you can find an example of how to create a backend.tf file on this [Wiki Page](https://github.com/meshcloud/building-blocks/wiki/%5BUser-Guide%5D-Setting-up-the-Backend-for-terraform-state#how-to-configure-backendtf-file-for-these-providers)