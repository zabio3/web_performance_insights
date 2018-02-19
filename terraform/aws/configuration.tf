provider "aws" {
  region = "ap-northeast-1"
}

# この辺りのIDは別にバレても問題ない
resource "aws_instance" "ec2" {
  ami = "ami-c91a8eaf"
  instance_type = "t2.micro"
  key_name = "accelia_ansible_kusu"
  vpc_security_group_ids = [
    #"sg-96d478ef"
    "sg-ef7f0696"
  ]
  # subnet_id = "subnet-199d4e42"
  subnet_id = "subnet-79dc930f"
  # vpc内のmasterサーバから操作させるため
  associate_public_ip_address = "true"
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination = "false"
  monitoring = "false"
  ebs_block_device = {
    device_name = "/dev/xvda"
    volume_type = "gp2"
    volume_size = "8"
  }
  tags = {
    Name = "pagespeed_verify_server"
  }
}

output "public ip" {
  value = "${aws_instance.ec2.public_ip}"
}