# FAQ

### Does the collie hub contain production-ready kit modules?

Yes! Many of the modules published on collie hub reuse terraform code made available by cloud providers in Frameworks like Azure Enterprise Scale or Google Cloud Fast Fabric.
They also follow conceptual best-practices developed by the [cloudfoundation.org](https://cloudfoundation.org) community published in the [Cloud Foundation Maturity Model](https://cloudfoundation.org/maturity-model/).

### Do I have to be familiar with terraform and terragrunt to use collie?

You should be familiar with terraform in order to use collie effectively. Collie offers an opinionated workflow that lends itself to building
complex landing zones and uses `terragrunt` to accomplish this. Familiarity with terragrunt is not required,
though you will most likely find it useful to pick up some of its concepts along the way.

### Do I have to use `collie` cli for working with the Collie Hub?

Not necessarily - `collie` cli transparently invokes other tools like `terragrunt` for you. You can see every command that collie invokes using the `--verbose` flag.
However, collie offers a comfortable developer workflow and many useful utilities to help you inspect your cloud foundation.