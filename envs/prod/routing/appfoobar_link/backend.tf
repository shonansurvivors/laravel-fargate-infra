terraform {
  backend "s3" {
    bucket = "shonansurvivors-tfstate"
    key    = "example/prod/routing/appfoobar_link_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
