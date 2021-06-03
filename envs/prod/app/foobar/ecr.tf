module "nginx" {
  source = "../../../../modules/ecr"

  name = "example-prod-foobar-nginx"
}
