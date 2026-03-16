variable "ami_id" {
  description = "RedHat AMI"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair"
  type        = string
}
