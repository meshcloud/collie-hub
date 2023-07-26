# Bootstrapping

Setting up a new cloud platform entails some operations that cannot be automated and require manual execution.
This manual execution also typically needs very high privileges because you need to setup global configuration
for the entire cloud platform.

**Bootstrapping** is the process of executing a set of manual or semi-automated steps
that prepare a cloud platform for automated deployment.

Collie assumes that platform bootstrapping is a process that's always done with a
"human in the loop". Every cloud platform in a collie repository can have exactly one `bootstrap` module
that contains the code to prepare your cloud platform accordingly.

A bootstrap typically performs the following tasks

- setting up an automation user and credentials to deploy all other platform modules
- setting up a terraform state backend, e.g. an S3 Bucket and IAM permissions for platform team members to work with it

The `collie foundation deploy` command executes all but the `bootstrap` module by default. To execute only the bootstrap module, pass the `--bootstrap` flag.
