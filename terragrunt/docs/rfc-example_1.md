# RFC - Terragrunt Bootstrapping

## Background

Terragrunt is a thin wrapper for Terraform that provides extra tools for keeping Terraform configurations DRY. When first setting up Terragrunt, there can be a "chicken and egg" bootstrap problem where Terragrunt needs remote state and locking resources to function properly, but Terragrunt itself is required to create those resources.

## Problem

When first adopting Terragrunt, there is a bootstrapping challenge around setting up remote state and locking resources. Terragrunt needs these resources to run, but Terragrunt itself is needed to create these resources initially. This leads to a "chicken and egg" situation.

## Proposal

Use a lightweight manual bootstrap process to create a basic Terragrunt set up that can then be used to create the remaining infrastructure in a sustainable way.

[Source](../ex1/)

```bash
.
├── README.md
└── terragrunt
    ├── ex1
    │   ├── docs
    │   ├── common.hcl
    │   ├── env
    │   │   ├── dev
    │   │   ├── staging
    │   │   └── workload.json
    │   ├── terragrunt.hcl
    │   └── workspace.hcl
```

### Chicken and Egg Bootstrapping

#### Steps

1. Plan the bootstrap

   ```bash
    cd terragrunt/ex1/env/staging
    terragrunt run-all apply --terragrunt-working-dir bootstrap
   ```

2. Import necessary resources like S3 bucket

   ```bash
   terragrunt import 'aws_s3_bucket.mb' staging-tfs-iac-patterns
   ```

   OR

   ```yaml
   # bootstrap/import.tf
   resource "time_sleep" "wait_20_seconds" {
   depends_on = [null_resource.previous]
   create_duration = "20s"
   }

   resource "null_resource" "next" {
   depends_on = [time_sleep.wait_20_seconds]
   }

   import {
   to = aws_s3_bucket.mb
   id = "staging-tfs-aws-iac-patterns"
   }
   ```

3. Apply the bootstrap

   ```bash
   cd terragrunt/ex1/env/staging
   terragrunt run-all apply --terragrunt-working-dir bootstrap
   ```

## Definition of success

The bootstrap process is successful if it creates a viable Terragrunt set up that can then be used to manage all environments and resources going forward.

## Cost

The bootstrap process only requires a small amount of manual effort up front and a lightweight Terraform state. Ongoing costs come from standard Terragrunt remote state/locking resources.
