locals {
  name_prefix = "${var.env}-${var.component}"
  tags        = merge(var.tags,  {tf-module = "apps" }, {env=var.env})
  parameters  = concat(var.parameters, [var.component])
  policy_resources = [ for i in local.parameters: "arn:aws:ssm:us-east-1:043254050286:parameter/${i}.${var.env}.*" ]
}