variable "vpc_id" {
    description = "This is the VPC ID the ElasticSearch Domain needs to be deployed in"
    default = "test-vpc"
    type = string
}

variable "domain_name"{
    description = "Name of the ElasticSearch domain"
    default = "test_domain"
    type = string
}

variable "region" {
    description = "This is the region where the ElasticSearch domain will be deployed in"
    default = "us-east-1"
    type = string
}

variable "subnet_id" {
    description = "This is the subnet IDs where the ElasticSearch will be deployed in"
    default = "subnet-id"
    type = string
}

variable "ebs_volume_size" {
    description = "EBS volume size of the data nodes (GB)"
    default = 10
    type = number
}

variable "no_of_datanodes" {
    description = "Number of data nodes of the ElasticSearch domain"
    default = 1
    type = number
}

variable "instance_type" {
    description = "Instance type of the data node"
    default = "t2.micro.elasticsearch"
    type = string
}

variable "dedicated_master_type" {
    description = "Instance type of the master node"
    default = "t2.small.elasticsearch"
    type = string
}

variable "dedicated_master_count" {
    description = "Instance count of the master node"
    default = 1
    type = number
}

