# Remote State for DEV
locals{
  environment     = find_in_parent_folders("env")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "staging-tfs-${basename(get_repo_root())}"
    key            = "env/staging/${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "tf3-lock-table"
  }
}