# Scalelite-Lazy

## Requirements

- AWS Account
- Route53 Domain Name and Domain Zone
- Terraform 13.0+

## Pre-Install

Adjust configurations:

- [`vars/variables.tfvars`](vars/variables.tfvars)

## Infrastructure

Infrastructure creation is done in multiple steps:

1. Bootstrapping - creating shared resources, like security groups and SSH keys.
2. Provisioning - creating actual bigbluebutton and scalelite servers

### Bootstrapping

Initiate a new Terraform project in [`bootstrap`](bootstrap) directory:

```sh
terraform init
```

Plan and apply your changes, provisionning the resources:

```sh
terraform apply -var-file=../vars/variables.tfvars
```

### Provisioning

Initiate a new Terraform project in [`template`](template) directory:

```sh
terraform init
```

Plan and apply your changes, provisionning the resources:

```sh
terraform apply -var-file=../vars/variables.tfvars
```

## Post-Install

Post installation configuration is still pretty much manual. You will need to refer to [scalelite official docs](https://github.com/blindsidenetworks/scalelite#administration) to learn more how to administer your pool.

In case you need to destroy the resources, the process is similar for both [`bootstrap`](bootstrap) and [`template`](template):

```sh
terraform destroy --auto-approve -var-file=../vars/variables.tfvars
```
