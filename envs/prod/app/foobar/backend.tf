terraform {
  backend "s3" {
    bucket  = "shonansurvivors-tfstate"
    key     = "example/prod/app/foobar_v0.15.4.tfstate"
    region  = "ap-northeast-1"
  }
}
