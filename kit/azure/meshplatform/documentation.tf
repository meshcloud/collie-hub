output "documentation_md" {
  value = <<EOF
# meshStack Integration

meshStack integration sets up this AAD tenant as a meshPlatform.
To do this we create AAD tenant-level service principals, allowing meshStack to access data
and orchestrate Azure platform functionality.

## Replicator Service Principal
 - Application Client ID: ${module.meshplatform.replicator_service_principal["Application_Client_ID"]}
 - Enterprise Application Object ID: ${module.meshplatform.replicator_service_principal["Enterprise_Application_Object_ID"]}
 - Client_Secret:  ${module.meshplatform.replicator_service_principal["Client_Secret"]}

## Metering Service Principal
 - Application Client ID: ${module.meshplatform.metering_service_principal["Application_Client_ID"]}
 - Enterprise Application Object ID: ${module.meshplatform.metering_service_principal["Enterprise_Application_Object_ID"]}
 - Client_Secret:  ${module.meshplatform.metering_service_principal["Client_Secret"]}

EOF
}
