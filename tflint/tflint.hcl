config {
  plugin_dir = "~/.tflint.d/plugins"

  ignore_module = {
    "terraform-aws-modules/vpc/aws"            = true
    "terraform-aws-modules/security-group/aws" = true
  }

}

plugin "aws" {
    enabled = true
    version = "0.30.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}


rule "terraform_required_version" {
  enabled = false
}
rule "terraform_module_version" {
  enabled = false
}
