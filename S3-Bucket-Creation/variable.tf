variable "region" {
    default = "ap-south-1"
}

variable "vpc_cidr" {
     default = "17.68.0.0/16"
}

variable "subnet_cidr" {
     default = "17.68.0.0/24"
}

variable "instance_type" {
   default = "t3.micro"
}
