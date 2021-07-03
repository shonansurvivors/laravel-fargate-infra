data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "shonansurvivors-tfstate"
    key    = "${local.system_name}/${local.env_name}/network/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "db_foobar" {
  backend = "s3"

  config = {
    bucket = "shonansurvivors-tfstate"
    key    = "${local.system_name}/${local.env_name}/db/foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "cache_foobar" {
  backend = "s3"

  config = {
    bucket = "shonansurvivors-tfstate"
    key    = "${local.system_name}/${local.env_name}/cache/foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
