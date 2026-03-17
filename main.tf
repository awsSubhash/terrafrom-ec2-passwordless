resource "aws_instance" "ec2-server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  user_data = <<-EOF
#!/bin/bash

USERNAME="subhash"
PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrjFOXEHv8XayVTBqgkHog2gt+TqXOwy5culmTK68Oa SYNAMEDIA+skumarsingh@LTskumars-0DB88"

useradd -m -s /bin/bash $USERNAME
mkdir -p /home/$USERNAME/.ssh

echo "$PUBLIC_KEY" > /home/$USERNAME/.ssh/authorized_keys

chmod 700 /home/$USERNAME/.ssh
chmod 600 /home/$USERNAME/.ssh/authorized_keys

chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME
chmod 440 /etc/sudoers.d/$USERNAME
EOF

  tags = {
    Name = "ec2-server"
  }
}
