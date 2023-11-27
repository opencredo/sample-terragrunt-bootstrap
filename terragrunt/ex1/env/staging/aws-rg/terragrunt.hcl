# A region for development resources
include {
    path = find_in_parent_folders()
}

terraform {
   source = "git::https://oauth:${local.common.locals.github_token}@github.com/opencredo/terraform-modules.git//rg"
}

locals {
    common        = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = merge(
  local.common.inputs,
  {
      name          = "dev-rg"
      environment   = local.common.locals.environment
  }
)

