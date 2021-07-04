resource "aws_iam_user" "github" {
  name = "${local.name_prefix}-${local.service_name}-github"

  tags = {
    Name = "${local.name_prefix}-${local.service_name}-github"
  }
}

resource "aws_iam_role" "deployer" {
  name = "${local.name_prefix}-${local.service_name}-deployer"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole",
            "sts:TagSession"
          ],
          "Principal" : {
            "AWS" : aws_iam_user.github.arn
          }
        }
      ]
    }
  )

  tags = {
    Name = "${local.name_prefix}-${local.service_name}-deployer"
  }
}

data "aws_iam_policy" "ecr_power_user" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "role_deployer_policy_ecr_power_user" {
  role       = aws_iam_role.deployer.name
  policy_arn = data.aws_iam_policy.ecr_power_user.arn
}

resource "aws_iam_role_policy" "s3" {
  name = "s3"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject"
          ],
          "Resource" : "arn:aws:s3:::shonansurvivors-tfstate/${local.system_name}/${local.env_name}/cicd/app_${local.service_name}_*.tfstate"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:PutObject"
          ],
          "Resource" : "${data.aws_s3_bucket.env_file.arn}/*"
        },
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecs" {
  name = "ecs"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "RegisterTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "ecs:RegisterTaskDefinition",
            "ecs:ListTaskDefinitions",
            "ecs:DescribeTaskDefinition"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "PassRolesInTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "iam:PassRole"
          ],
          "Resource" : [
            data.aws_iam_role.ecs_task.arn,
            data.aws_iam_role.ecs_task_execution.arn,
          ]
        },
        {
          "Sid" : "DeployService",
          "Effect" : "Allow",
          "Action" : [
            "ecs:UpdateService",
            "ecs:DescribeServices"
          ],
          "Resource" : [
            data.aws_ecs_service.this.arn
          ]
        },
        {
          "Sid" : "RunAndWaitTask",
          "Effect" : "Allow",
          "Action" : [
            "ecs:RunTask",
            "ecs:DescribeTasks"
          ],
          "Condition" : {
            "ArnEquals" : {
              "ecs:cluster" : data.aws_ecs_cluster.this.arn
            }
          },
          "Resource" : [
            "arn:aws:ecs:${data.aws_region.current.id}:${data.aws_caller_identity.self.id}:task-definition/${local.name_prefix}-${local.service_name}:*",
            "arn:aws:ecs:${data.aws_region.current.id}:${data.aws_caller_identity.self.id}:task/*"
          ]
        },
        {
          "Sid" : "GetLogEvents",
          "Effect" : "Allow",
          "Action" : [
            "logs:GetLogEvents"
          ],
          "Resource" : [
            data.aws_cloudwatch_log_group.nginx.arn,
            data.aws_cloudwatch_log_group.php.arn
          ]
        }
      ]
    }
  )
}
