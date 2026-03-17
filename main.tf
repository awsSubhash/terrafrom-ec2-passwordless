resource "aws_instance" "jenkins_server" {

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  user_data = <<-EOF
#!/bin/bash

# -----------------------------
# USER CONFIGURATION SECTION
# -----------------------------
# Change the username if needed
USERNAME="subhash"

# Replace this with your own public SSH key
PUBLIC_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrjFOXEHv8XayVTBqgkHog2gt+TqXOwy5culmTK68Oa SYNAMEDIA+skumarsingh@LTskumars-0DB88"


# -----------------------------
# CREATE NEW USER
# -m : create home directory
# -s : default shell
# -----------------------------
useradd -m -s /bin/bash $USERNAME


# -----------------------------
# CREATE .ssh DIRECTORY
# This is required for SSH key authentication
# -----------------------------
mkdir -p /home/$USERNAME/.ssh


# -----------------------------
# ADD PUBLIC KEY
# This enables passwordless SSH login
# Replace PUBLIC_KEY variable if needed
# -----------------------------
echo "$PUBLIC_KEY" > /home/$USERNAME/.ssh/authorized_keys


# -----------------------------
# SET SECURE PERMISSIONS
# SSH requires strict permissions
# -----------------------------
chmod 700 /home/$USERNAME/.ssh
chmod 600 /home/$USERNAME/.ssh/authorized_keys


# -----------------------------
# SET CORRECT OWNERSHIP
# Ensure the new user owns the SSH files
# -----------------------------
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh


# -----------------------------
# OPTIONAL: GIVE PASSWORDLESS SUDO ACCESS
# Remove this section if sudo access is not required
# -----------------------------
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME
chmod 440 /etc/sudoers.d/$USERNAME


# -----------------------------
# SCRIPT COMPLETE
# You can now login using:
# ssh USERNAME@EC2_PUBLIC_IP
# -----------------------------
  tags = {
    Name = "Terraform-Jenkins-Server"
  }
}
