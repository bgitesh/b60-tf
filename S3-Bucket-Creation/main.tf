#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "my_subnet" {
   vpc_id = aws_vpc.my_vpc.id
   cidr_block = var.subnet_cidr
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id
  
  ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
   most_recent = true
   owners = ["099720109477"]

   filter {
      
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
   }  
}

# EC2
resource "aws_instance" "my_ec2" {
   ami = data.aws_ami.ubuntu.id
   instance_type = var.instance_type

   subnet_id = aws_subnet.my_subnet.id
   vpc_security_group_ids = [aws_security_group.my_sg.id]

   tags = {
      Name = "Terraform instance"
   }
}

#s3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket-name-1306"

  tags = {
   Name = "MyBucket"
  }
}