resource "null_resource" "previous" {}

# tflint-ignore: terraform_required_providers
resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "30s"
}

# tflint-ignore: terraform_required_providers
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_30_seconds]
}

import {
  to = aws_s3_bucket.mb
  id = "staging-tfs-sample-terragrunt-bootstrap"
}
