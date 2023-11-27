include {
    path = find_in_parent_folders()
}

terraform {
   source = "git::https://oauth:${local.common.locals.github_token}@github.com/opencredo/terraform-modules.git//tfstate"
}


locals {
    common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  bucket_name   = "${local.common.locals.environment}-tfs-${basename(get_repo_root())}"
  
}