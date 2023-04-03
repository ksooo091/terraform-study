

resource "aws_iam_role" "codebuild_iam_role" {
  name = "codebuild-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_role_policy" {
  role = aws_iam_role.codebuild_iam_role.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
            "Effect": "Allow",
            "Resource": [
                "${aws_codecommit_repository.frontend.arn}",
            ],
            "Action": [
                "codecommit:GitPull"
            ]
        },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*",
        "codebuild:*",
        "cloudwatch:GetMetricStatistics",
        "ec2:DescribeVpcs",
        "ec2:DescribeDhcpOptions",
        "ec2:CreateNetworkInterface",
        "ec2:DescribeRouteTables",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "elasticfilesystem:DescribeFileSystems",
        "events:DeleteRule",
        "events:DescribeRule",
        "events:DisableRule",
        "events:EnableRule",
        "events:ListTargetsByRule",
        "events:ListRuleNamesByTarget",
        "events:PutRule",
        "events:PutTargets",
        "events:RemoveTargets",
        "logs:GetLogEvents",
        "eks:ListClusters",
        "eks:DescribeCluster"

      ],
      "Resource": "*"
      }  ,
    {
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:CompleteLayerUpload",
        "ecr:GetAuthorizationToken",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }, {
      "Action": [
        "ecr:CreateRepository"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
     {
            "Effect": "Allow",
            "Action": "eks:DescribeCluster",
            "Resource": "arn:aws:eks:*:*:cluster/*"
        },
        {
  "Effect": "Allow",
  "Action": "ec2:CreateNetworkInterfacePermission",
  "Resource": "arn:aws:ec2:*:*:network-interface/*",
  "Condition": {
    "StringLike": {
      "ec2:AuthorizedService": "codebuild.amazonaws.com",
      "ec2:Subnet": [
        "arn:aws:ec2:*:*:subnet/*"
      ]
    }
  }
}
  ]
}
POLICY
}

resource "aws_codebuild_project" "codebuild_project_front" {
  name          = "Front_Build"
  description   = "Front"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_iam_role.arn
  vpc_config {
    vpc_id = aws_vpc.eks_vpc
    subnets = [
      aws_subnet.eks_private_a_1.id,
      aws_subnet.eks_private_c_1.id,
    ]

    // TODO 보안그룹 수정시 변경 
    security_group_ids = [
      aws_default_security_group. .id
    ]
  }


  artifacts {
    type = "NO_ARTIFACTS"
  }
  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

  }
  logs_config {
    cloudwatch_logs {
      group_name  = "front codebuild log"
    }

  }
  source {
    type            = "CODECOMMIT"
    location        = aws_codecommit_repository.frontend-server.clone_url_http
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
  source_version = "main"
}






resource "aws_codebuild_project" "codebuild_project_back" {
  name          = "Back_Build"
  description   = "Back"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_iam_role.arn

  vpc_config {
    vpc_id = aws_vpc.eks_vpc
    subnets = [
      aws_subnet.eks_private_a_1.id,
      aws_subnet.eks_private_c_1.id,
    ]

    // TODO 보안그룹 수정시 변경 
    security_group_ids = [
      aws_default_security_group. .id
    ]
  }


  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }


  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true


    # environment_variable {
    #   name  = "SOME_KEY2"
    #   value = "SOME_VALUE2"
    #   type  = "PARAMETER_STORE"
    # }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "Back CodeBuild Log"
    }

  }

  source {
    type            = "GITHUB"
    location        = var.GITHUB_LINK
    git_clone_depth = 1
    auth {
      type = "OAUTH"
      resource = "https://github.com"
      value = var.GITHUB_TOKEN
    }
    git_submodules_config {
      fetch_submodules = true
    }
  }

  source_version = "main"

  tags = {
    Environment = "Test"
  }
}
