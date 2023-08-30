# Goals of Collie

The goals of Collie and the Collie Hub are to

- provide a **jumpstart** for building landing zones for every cloud platform based on common best practices
- **empower platform engineering teams** to build landing zones using a straightforward workflow leveraging plain terraform modules
- enable **collaboration** between platform engineers, application engineers and security stakeholders through automatically maintained documentation
- build on **established and proven tooling** instead of re-inventing the wheel with custom orchestration and scripting
- provide a **consistent** tooling and workflow experience for managing landing zones across all major cloud platforms

## Why Collie Exists

Building a landing zone is a complex undertaking for platform engineers. Not only do you have to juggle the technical
complexities of your cloud platform, but also make foundational decisions about how your organization will build on the
cloud for years to come.

The members of the [cloudfoundation.org community](https://cloudfoundation.org/?ref=github-collie-cli) have collectively
built hundreds of landing zones in different organization using a wide variety of tools and frameworks. Throughout this
experience, we have seen many landing zone projects caught up in the same common pitfalls

- the myriad of cloud services and nearly endless flexibility to design policies leads to **analysis paralysis** in the
  organization and an inability to make progress on landing zone design decisions
- starved of clear requirements, platform engineers then divert their energy to building **complex custom tooling and machinery** for
  deploying and operating landing zones instead of delivering differentiated functionality relevant to the organization's cloud usage
- an intense focus on technically challenging implementation details leads to **missing the forest for the trees**, with solutions that look great on the whiteboard but fail to meet the real-world needs of application teams

There are many great resources already out there on how to build landing zones, including official guidance and frameworks
from cloud providers that is becoming ever more comprehensive every day. These frameworks provide a great reference
for showcasing what's possible at the expense of enabling platform engineers to make lean choices about what's essential
for their organization.

## Design Philosophy

With these challenges in mind, Collie is designed as a lightweight **tool instead of a fat framework**. Collie enables platform engineers to **incrementally add capabilities** to their landing zones with **plain terraform code instead of yaml** configuration.

The collie cli provides a **transparent wrapper** around well-established tooling like terraform and terragrunt, providing a
convenient developer experience for core workflows like editing, deploying and documenting landing zones.

The community-maintained modules from Collie Hub offer useful starting points that incorporate essential best practices from
official cloud provider landing zone frameworks like Azure Enterprise Scale or Google Cloud Fabric FAST. Platform engineers
can use these modules as starting points for their own landing zones in a **"fork and own"** model.

Collie's workflows emphasise keeping a "human in the loop" for changes to core landing zone infrastructure instead
of delivering an overly complex automation solution that doesn't pull its own weight.

Finally, Collie integrates generation of markdown-based **documentation** from your terraform code as an essential means
for collaborating between platform engineers, application engineers and security stakeholders.
