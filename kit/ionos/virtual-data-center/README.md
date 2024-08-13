# IONOS Virtual Data Center Building Block

Module that creates a Virtual Data Center in IONOS Cloud and assigns users in meshStack with Project permissions
in the newly created Virtual Data Center.
You can use it as a self-built platform integration in meshStack.

## How to create this Platform Integration in meshStack

1. Go to your meshStack Admin Area and click on "Platforms > Platforms" from the left pane
2. Click on "Create Platform"
3. For Platform Type, click the dropdown and hit "Create new Platform Type"
4. In this modal, enter a fitting name and identifier for your new IONOS platform
   - For an icon, you can use the file under `./icon.png`.
5. Continue the Platform Creation process.
6. Next, you will have to create a Building Block that will connect the Terraform and the newly created Platform.
7. On the left-hand side go to "Marketplace > Building Blocks" and click "Definitions".
8. Click "Create new Definition" and fill in some general information like name and description.
9. On the next page, set the following:
   - Supported Platforms -> Pick the Platform Type you created in Step 3.
   - How often assigned -> Once
   - Implementation Type -> Terraform
   - Terraform Version -> 1.5
   - Git Repository URL -> This repository, or, if you fork the code, your own repository
   - Git Repository Path -> `other-providers/ionos/virtual-data-center`
   - Enter a SSH Key if you are running from a private repository.
   - Enter a known host (if you are running from a self-hosted Git provider)
   - Deletion Mode -> pick "Delete Resources" if you want a `tf destroy` to run upon deletion in meshStack.
10. Go to the next page and skip the Dependency selection
11. For the Inputs, create the following Inputs:
    - `IONOS_TOKEN` (if you don't use an API token but username & password instead,
      you can do so as well with `IONOS_USERNAME` and `IONOS_PASSWORD`)
      - Set Source -> Static
      - Provide as -> Environment Variable
      - Set the variable to encryped
      - Enter your IONOS API Token as a value
    - Generate the necessary Terraform variables.
      To do so, at the top right click "Generate Inputs > Load Inputs" and paste in the content
      from `./variables.tf`
      - Set the `workspace_id` Source -> Workspace Identifier
      - Set the `project_id` Source -> Project Identifier
      - Set the `users` Source -> User Permissions
    - Backend configuration:
       - Select "File" as input type and upload the backend.tf file.
       - Add related environment variables based on your backend configuration (e.g. client_id and client_secret for azure, SA_ID and SA_EMAIL for GCS)
12. Go to the next page, which is Outputs, and create the following output:
    - `tenant_id`
      - Set the Assignment Type -> Platform Tenant ID
13. Create the new Building Block Definition
14. As a last step, we have to hook the new Building Block definition into a new landing zone so it will be rolled out on tenant creation.
15. On the left-hand side navigate to "Platforms > Platforms" and open your newly created IONOS platform.
16. Go to the Landing Zones tab and click "Create new Landing Zone"
17. Enter a fitting name, description and tags.
18. Under "Building Blocks" pick your newly created Building Block Definition and set it to "Mandatory".
19. Click Save
20. ✅ Your platform integration is successfully set up and workspaces can now freely book new tenants (Virtual Data Centers)
    for your platform.
