# Goals

The goals of the Landing Zone Construction Kit are

- provide a **jumpstart** for building landing zones for every cloud platform based on common best practices
- **empower software engineering teams** to configure cloud tenants exactly to their needs leveraging a modular approach
- enable **collaboration** between platform engineers, application engineers and security stakeholders through GitOps & structured documentation
- provide a **consistent** tooling and workflow experience across all major cloud platforms
- build on **established and proven tooling** instead of re-inventing the wheel with custom orchestration and scripting

## Design Philosophy

Building Landing Zones is a complex task and the journey of building a solid landing zone implementation is fraught with many pitfalls. We therefore made some deliberate decisions to stay clear of these traps

- prefer operator control over unsupervised automation for changes to landing zone core infrastructure
- empower building of custom modules ("fork and own") instead of modules that achieve re-usability only through complex configuration models

<!-- todo: expand on reasoning behind these choices -->

## Inspirations and Related Resources

There are many great resources already out there on how to build landing zones.

<!-- todo: add links here and discussion of relative benefits-->

Most of these are provided directly by cloud providers or partners specializing on a particular cloud. Cloud Foundation teams that want to enable a multi-cloud strategy need to build and operate landing zones across different clouds. Learning a new workflow or tooling for every platform takes away time from delivering differentiated functionality relevant to the organization. Landing zone construction kit solves this challenge by providing a unified workflow.
