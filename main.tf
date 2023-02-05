

data "aws_vpc" "es_vpc" {
    id = var.vpc_id
}

data "aws_subnets" "es_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_security_group" "es" {
  name        = "${var.domain_name}-elasticsearch-sg"
  description = "Managed by Terraform"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      data.aws_vpc.es_vpc.cidr_block,
    ]
  }
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain_name
  elasticsearch_version = "6.3"

  cluster_config {
    instance_type          = var.instance_type
    /*
    zone_awareness_enabled = true
    dedicated_master_count = var.dedicated_master_count
    dedicated_master_type = var.dedicated_master_type
    */
  }

  vpc_options {
    subnet_ids = [
      data.aws_subnets.es_subnets.ids[5]
    ]

    security_group_ids = [aws_security_group.es.id]
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
    volume_type = "gp3"
  }
/*
  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
CONFIG
*/
  tags = {
    Domain = var.domain_name
  }

  depends_on = [aws_iam_service_linked_role.es]
}