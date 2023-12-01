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
    bucket         = "dev-td-${basename(get_repo_root())}"
    key            = "env/dev/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}