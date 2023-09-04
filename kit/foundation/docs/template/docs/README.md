# Welcome to MyOrg Cloud Foundation

> 🚧 Change MyOrg to your organization name.

Welcome to MyOrg Cloud Foundation. Our team's job is to help you get your applications to the cloud.

> 🚧 Introduce your team

| Name       | Role                 |
|------------|----------------------|
| Eric Adams | Enterprise Architect |
| Phil       | Platform Engineer    |

## Your way to the cloud

> 🚧 Describe how application teams in your organization can get to the cloud.

Cloud adoption has two phases.

1. The planning phase often begins with our consulting hours: Here you can inform yourself and ask your questions. In this phase you will choose a cloud provider and landing zone. Please note that not every service is available from every provider and landing zone. We recommend to create a solution design at this stage. Our cloud solution architects will support you in this.
2. The implementation phase begins when you have access to your cloud environment. Now it's time for the big move - migrate your application and if necessary your data!

## Cloud Providers

> 🚧 If you have a company wide cloud strategy, here's a good place to link to it.

> 🚧 Adapt the list of cloud providers you want to offer. If you plan on using different clouds for different kinds of use cases (e.g. "boutique cloud" approach) then describe who is a cloud partner for what.

Our strategic cloud partners are

- AWS
- Google
- Microsoft

We offer [landing zones](./concepts.md#landing-zone) for each of those [platforms](/platforms/).

## Shared Responsibility Model

For our cloud offering, we rely on sharing responsibilities across three parties: cloud provider, cloud foundation team, and you (the application team).
It’s critical to understand which security tasks are handled by whom.

## Common responsibilities across all landing zones

The responsibility documented in the below table holds for all our offerings.

|                                                      | application team     | cloud foundation     | cloud provider     |
|:----------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Physical hosts**                                   |                      |                      | X                  |
| **Physical network**                                 |                      |                      | X                  |
| **Physical datacenter**                              |                      |                      | X                  |
| **Identities, SSO on cloud platform**                |                      | X                    |                    |
| **Audit Logs for calls against cloud platform APIs** |                      | X                    |                    |
| **Permissions on the cloud platform**                | X                    |                      |                    |
| **Costs**                                            | X                    |                      |                    |

> As a ground rule we apply the following principle: **If you deploy it, you own it**. Any resources that application
> teams deploy to Azure are owned and must be secured by this application team. Deviations from this model for resources
> where a shared responsibility model applies are expressly documented for each landing zone and building block offered
> by the cloud foundation team.

## Landing Zones and Responsibilities

> 🚧 Adapt the list of landing zones you want to offer.

> 🚧 The use landing zones in this template are split by connectivity and use-case model. For more information on modeling landing zones, see [the meshcloud ultimate landing zone guide](https://www.meshcloud.io/wp-content/uploads/The-Ultimate-Landing-Zone-Guide-EN.pdf).

The Landing Zones we offer are divided by use cases and networking requirements.
The different Landing Zones offer different trade-offs between freedom & responsibilities.

### Lift-and-Shift Landing Zone with connection to on-prem

Use this landing zone if you want to migrate workload from on-prem to the cloud with minimal effort.

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Operating system**                                |                      | X                    |                    |
| **Network controls**                                |                      | X                    |                    |
| **Connectivity towards on-prem**                    |                      | X                    |                    |

### Cloud Native Landing Zone with connection to on-prem

Use this landing zone if you want to modernize or re-write an existing application or write a new application from scratch.

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Operating system**                                | X                    |                      |                    |
| **Network controls**                                |                      | X                    |                    |
| **Connectivity towards on-prem**                    |                      | X                    |                    |

### Cloud Native Landing Zone without connection to on-prem

Use this landing zone if you want to modernize or re-write an existing application or write a new application from scratch.
Because this landing zone does not connect to on-prem, this landing zone is a popular choice for testing out the capabilities of a cloud provider.

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Securing all endpoints of your application**      | X                    |                      |                    |
| **Operating system**                                | X                    |                      |                    |
| **Network controls**                                |                      | X                    |                    |
| **Connectivity towards on-prem**                    |                      | X                    |                    |

