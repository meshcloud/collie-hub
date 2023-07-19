# Welcome to Cloud Foundation

## Your way to the cloud

Cloud adoption has two phases:
- The planning phase often begins with our consulting hours: Here you can inform yourself and ask your questions. In this phase you will choose a cloud provider and landing zone. Please note that not every service is available from every provider and landing zone. We recommend to create a solution design at this stage. Our cloud solution architects will support you in this.
- The implementation phase begins when you have access to your cloud tenant. Now it's time for the big move - migrate your application and if necessary your data!

## Cloud Providers

> 🚧 Adapt the list of cloud providers you want to offer.

Our strategic cloud partners are
- AWS
- Google
- Microsoft

We offer [landing zones](concepts.md#landing-zone) for each of those [platforms](/platforms/).

## Shared Responsibility Model

For our cloud offering, we rely on sharing responsibilities across three parties: cloud provider, cloud foundation team, and you (the application team).
It’s critical to understand which security tasks are handled by whom.

## Common responsibilities across all landing zones

The following responsiblities are with the cloud provider for all landing zones:
- Physical hosts
- Physical network
- Physical datacenter

The following responsibilities are with the cloud foundation team for all landing zones:
- Identities, SSO on cloud platform
- Audit Logs for calls against cloud platform APIs

The following responsibilities are with the applicaiton team for all landing zones:
- Permissions on the cloud platform

## Landing Zones and Responsibilities

> 🚧 Adapt the list of landing zones you want to offer.

The Landing Zones we offer are divided by use cases and networking requirements.
The different Landing Zones offer different trade-offs between freedom & responsibilities.

### Lift-and-Shift Landing Zone with connection to on-prem

Use this landing zone if you want to migrate workload from on-prem to the cloud with minimal effort.

In addition to the he following responsibilites are with the application team:
- Development and operations of your application
- Identities and Accounts within your application
- Information and data within your application
- Costs

The following responsibilities are with the cloud foundation team:
- Network controls
- Operating system

### Cloud Native Landing Zone with connection to on-prem

Use this landing zone if you want to modernize or re-write an existing application or write a new application from scratch.

The following responsibilites are with the application team:
- Development and operations of your application
- Identities and Accounts within your application
- Information and data within your application
- Operating system
- Costs

The following responsibilities are with the cloud foundation team:
- Network controls
- Connectivity towards on-prem

### Cloud Native Landing Zone without connection to on-prem

Use this landing zone if you want to modernize or re-write an existing application or write a new application from scratch.
Because this landing zone does not connect to on-prem, this landing zone is a popular choice for testing out the capabilities of a cloud provider.

The following responsibilites are with the application team:
- Development and operations of your application
- Identities and Accounts within your application
- Information and data within your application
- Securing all endpoints of your application
- Network controls
- Operating system
- Costs

