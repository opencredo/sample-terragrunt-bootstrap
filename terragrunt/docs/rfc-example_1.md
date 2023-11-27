# RFC - Terragrunt Bootstrapping

## Background

## Problem

## Proposal

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

## Cost
