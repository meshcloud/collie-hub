# Welcome to Likvid Bank Cloud Foundation

Welcome to Likvid Bank Cloud Foundation. Our team's job is to help you get your applications to the cloud.
This is our Team:

| Name       | Role                 |
|------------|----------------------|
| Anna Admin | Enterprise Architect |
| Oliver Operator       | Platform Engineer    |

> 💡 Likvid Bank is a demo organization of course and, unfortunately, Anna and Oliver don't really exist to help
> out with running this cloud foundation. This is why you will see meshcloud employees listed referenced in some documents instead.

## Your way to the cloud

The cloud is generally available to all applications that meet a minimum of regulatory compliance requirements.
In order to support compliance while at the same time enabling fast iteration and development of new applications,
the cloud onboarding process works as follow

::: tip
New to the cloud? Check out our [🚀 Starter Kits](https://panel.demo.meshcloud.io/#/landing-page/marketplace/catalog?searchTerm=Starter&sort=name,asc).
When ordering a starter kit, simply create a new Workspace and Project using the landing zone family `Sandbox` and select
confidentiality `public`.
:::

1. Product owners onboard their application and team members by creating a **Workspace** in our self-service
portal (meshStack).
2. Product owners now have access to create **Projects** in self-service that have access to *development and sandbox landing zones*.
3. Product owners complete the "Regulatory Onboarding - Cloud" process in the "Likvid Bank Compliance Tool". As part of this, you will receive a `RegulatoryOnboardingId` and can link your existing Workspace in our self-service Portal (meshStack).
4. Depending on the compliance classification of your application, you will now have access to create projects using *production landing zones*.


## Cloud Providers

Likvid Bank follows a "cloud smart" strategy. This means product owners are free to pick and combine the cloud services
and providers that they need.

We currently offer the following **public clouds**:

- AWS (preview)
- GCP (GA)
- Azure (GA)
- IONOS (preview)

We also offer managed kubernetes platforms operated by the Container Platform Team.

- AKS (on Azure, Frankfurt)
- OpenShift (on GCP, Frankfurt as well as On-Premises)

We offer various [landing zones](./concepts.md#landing-zone) for each of those platforms. Please see our
[platforms documentation](/platforms/) for more details.

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

> 🌤️ As a ground rule we apply the following principle: **If you deploy it, you own it**. Any resources that application
> teams deploy to Azure are owned and must be secured by this application team. Deviations from this model for resources
> where a shared responsibility model applies are expressly documented for each landing zone and building block offered
> by the cloud foundation team.

## Landing Zones and Responsibilities

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

### Cloud Native Landing Zone with internet connection

Use this landing zone if you want to modernize or re-write an existing application or write a new application from scratch.
Because this landing zone does not connect to on-prem, this landing zone is a popular choice for testing out the capabilities of a cloud provider.

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Securing all endpoints of your application**      | X                    |                      |                    |
| **Operating system**                                | X                    |                      |                    |
| **Network controls**                                | X                    |                      |                    |
| **Connectivity towards on-prem**                    |                      | *via building block* |                    |


### Container Platform Landing Zone

Use this landing zone if you want to run containerized workloads at scale. This landing zone is optimized for running container
workloads using services like Azure Kubernetes Service (AKS) and Azure Container Instances (ACI).

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Securing all endpoints of your application**      | X                    |                      |                    |
| **Operating system**                                |                      |                      | X                  |
| **Network controls**                                | x                    |                      |                    |

### Sandbox Landing Zone

Sandboxes are specifically designed for learning and experimentation. Sandboxes are strictly treated as **ephemeral** environments that must be torn down after an experiment has concluded. Sandboxes follow the "cloud native landing zone with internet connection"
model. They can place additional restrictions on available services to make the environments suitable for experimentation

|                                                     | application team     | cloud foundation     | cloud provider     |
|:---------------------------------------------------:|:--------------------:|:--------------------:|:------------------:|
| **Development and operations of your application**  | X                    |                      |                    |
| **Identities and Accounts within your application** | X                    |                      |                    |
| **Information and data within your application**    | X                    |                      |                    |
| **Securing all endpoints of your application**      | X                    |                      |                    |
| **Operating system**                                | X                    |                      |                    |
| **Network controls**                                | X                    |                      |                    |
| **Connectivity towards on-prem**                    | *not available*      |                      |                    |