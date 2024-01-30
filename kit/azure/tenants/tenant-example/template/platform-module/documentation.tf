output "documentation_md" {
  value = <<EOF
# Azure ${module.subscription.subscription_name}

this Tenant has following building blocks
 - subscription

## Tenant Responsibiltiy
 - NAME-HERE

## Landingzone Managment Group
 - ${module.subscription.landingzone_managment_group}

EOF
}
