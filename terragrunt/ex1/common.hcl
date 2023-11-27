locals {
    
    terragrunt_dir = get_original_terragrunt_dir()

    path_parts = split("/", local.terragrunt_dir)
    environment = element(local.path_parts, length(local.path_parts) - 2)

    github_token  =  get_env("TFTOKEN") 
    region        =  join("-", ["eu", "west", "2"])
    tags = {
        created_by = "terraform"
        orchestrated_by = "terragrunt"
        business_unit   = "platforms"
        business_owner  = "admin@opencredo.com"
        technical_owner = "admin@opencredo.com"
        workspace       = "${basename(get_terragrunt_dir())}"
        environment     = local.environment
    }


}

inputs = {
    github_token  = local.github_token
    region        =  local.region
}