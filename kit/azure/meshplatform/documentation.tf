output "documentation_md" {
  value = <<EOF
# meshStack Integration

meshStack integration sets up this AAD tenant as a meshPlatform.
To do this we create AAD tenant-level service principals, allowing meshStack to access data
and orchestrate Azure platform functionality.


## Replicator Service Principal

In order to manage user roles and permissions, meshcloud requires a Service Principal for the replicator
which is placed in the AAD Tenant containing your Azure Subscriptions and workloads. The Service Principal must be authorized in the scope of this AAD Tenant.

 - Application Client ID: ${module.meshplatform.replicator_service_principal["Application_Client_ID"]}
 - Enterprise Application Object ID: ${module.meshplatform.replicator_service_principal["Enterprise_Application_Object_ID"]}
 - Client_Secret:  ${module.meshplatform.replicator_service_principal["Client_Secret"]}

Cloud Platforms record events and other information about deployed cloud resources. Some of these events are relevant for metering. To read resource usage,
a metering principal is needed.

## Metering Service Principal
 - Application Client ID: ${module.meshplatform.metering_service_principal["Application_Client_ID"]}
 - Enterprise Application Object ID: ${module.meshplatform.metering_service_principal["Enterprise_Application_Object_ID"]}
 - Client_Secret:  ${module.meshplatform.metering_service_principal["Client_Secret"]}

EOF
}
