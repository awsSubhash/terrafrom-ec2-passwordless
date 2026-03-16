resource "aws_instance" "jenkins_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  user_data = <<-EOF
#!/bin/bash

sudo yum update -y
sudo yum install java-17-openjdk -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins

EOF

  tags = {
    Name = "Terraform-Jenkins-Server"
  }
}
