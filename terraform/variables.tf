variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "eu-west-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0324bce2436ce02b2"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "m7i-flex.large"
}
