# Compliance

Compliance controls refer to the policies, procedures, and technical measures put in place to ensure that an organization adheres to relevant laws, regulations, and industry standards. Compliance controls encountered by cloud foundation teams
aim to manage risks, maintain security, and ensure the integrity of systems and data.

## Controls 

For the purpose of building landing zones, we can think of compliance controls as a set of requirements
to be implemented in our landing zones. Depending on their implementation, controls can be categorized as technical 
or administrative controls:

1. **Technical Controls:** These are implemented through technology, such as firewalls, encryption, access controls, and monitoring systems. For instance, a technical control might involve setting up firewalls to restrict unauthorized access to sensitive data.

2. **Administrative Controls:** These controls involve policies, procedures, and guidelines that govern the behavior of individuals within an organization. Examples include security training for employees, defining roles and responsibilities, and establishing incident response protocols.

In most cases, an effective implementation of a control requires both technical and administrative measures.
Here's an example of such a control from the ISO 27001 framework.

```md
## A.9.1.1 Access Control Policy

An access control policy must be established, documented and reviewed regularly taking into account the requirements of the business 
for the assets in scope.
...
```

## Compliance Statements

If we think about an Azure Subscription as a "business asset", it becomes clear that an implementation of this control
needs to span both the technical and administrative domain:

- a role assignments of the `Contributor` role
- a policy that says that only software developers are assigned this role

We call the documentation of a compliance control's implementation a "compliance statement".

:::tip
When thinking about compliance it's very important to be clear about the **scope** that a control applies to.
For landing zones, we are talking about compliance of infrastructure components used by
application teams and how that enables compliance of applications building on top of them.
:::

## Compliance Frameworks

A compliance framework is a structured set of guidelines, best practices, and controls that help an organization manage compliance. It provides a systematic approach to ensure that necessary controls are identified, implemented, and monitored effectively. Frameworks like ISO 27001, NIST Cybersecurity Framework, or GDPR (General Data Protection Regulation) outline the controls and processes needed to achieve compliance in specific domains.

These frameworks help organizations by providing a blueprint for establishing and maintaining effective compliance programs. They streamline the process of understanding regulatory requirements, implementing controls, conducting audits, and continuously improving the compliance posture of an organization.
