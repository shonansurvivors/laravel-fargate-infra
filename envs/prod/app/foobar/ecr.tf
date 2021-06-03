module "nginx" {
  source = "../../../../modules/ecr"

  name = "example-prod-foobar-nginx"
}

module "php" {
  source = "../../../../modules/ecr"

  name = "example-prod-foobar-php"
}
