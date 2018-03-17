provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "ec2" {
  ami                    = "<your_ami_id>"
  instance_type          = "t2.micro"
  key_name               = "<your_key_name>"
  vpc_security_group_ids = ["<your_security_group_id>"]
  subnet_id              = "<your_subnet_id>"
  # Enable public IP for VPC master server access
  associate_public_ip_address = true
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination = false
  monitoring = false
  ebs_block_device = {
    device_name = "/dev/xvda"
    volume_type = "gp2"
    volume_size = "8"
  }
  tags = {
    Name = "<instance_name>"
  }
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}
