resource "aws_db_instance" "this" {
  // Engine options
  engine         = "mysql"
  engine_version = "8.0.25"

  // Settings
  identifier = "${local.system_name}-${local.env_name}-${local.service_name}"

  // Credentials Settings
  username = local.service_name
  password = "MustChangeStrongPassword!"

  // DB instance class
  instance_class = "db.t3.micro"

  // Storage
  storage_type          = "gp2"
  allocated_storage     = 20
  max_allocated_storage = 0

  // Availability & durability
  multi_az = false

  // Connectivity
  db_subnet_group_name = data.terraform_remote_state.network_main.outputs.db_subnet_group_this_id
  publicly_accessible  = false
  vpc_security_group_ids = [
    data.terraform_remote_state.network_main.outputs.security_group_db_foobar_id,
  ]
  availability_zone = "ap-northeast-1a"
  port              = 3306

  // Database authentication
  iam_database_authentication_enabled = false

  // Database options
  name                 = local.service_name
  parameter_group_name = aws_db_parameter_group.this.name
  option_group_name    = aws_db_option_group.this.name

  // Backup
  backup_retention_period  = 1
  backup_window            = "17:00-18:00"
  copy_tags_to_snapshot    = true
  delete_automated_backups = true
  skip_final_snapshot      = true

  // Encryption
  storage_encrypted = true
  kms_key_id        = data.aws_kms_alias.rds.target_key_arn

  // Performance Insights (db.t3.micro, db.t3.small are not supported)
  performance_insights_enabled = false
  # performance_insights_kms_key_id       = data.aws_kms_alias.rds.target_key_arn
  # performance_insights_retention_period = 7

  // Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_monitoring_role.arn

  // Log exports
  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery"
  ]

  // Maintenance
  auto_minor_version_upgrade = false
  maintenance_window         = "fri:18:00-fri:19:00"

  // Deletion protection
  deletion_protection = false

  tags = {
    Name = "${local.system_name}-${local.env_name}-${local.service_name}"
  }
}
