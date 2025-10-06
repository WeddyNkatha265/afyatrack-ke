output "web_server_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_eip.web.public_ip
}

output "web_server_url" {
  description = "URL to access the web application"
  value       = "http://${aws_eip.web.public_ip}:3000"
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i ~/Documents/awse2eproject.pem ubuntu@${aws_eip.web.public_ip}"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "ansible_inventory" {
  description = "Ansible inventory configuration"
  value = <<EOT
# Ansible Inventory for AfyaTrack KE
# Add this to your ansible/inventory.yml file

afyatrack_servers:
  hosts:
    afyatrack-vm:
      ansible_host: ${aws_eip.web.public_ip}
      ansible_user: ubuntu
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
EOT
}

output "ansible_deployment_command" {
  description = "Command to run Ansible deployment"
  value = "cd ansible && EC2_PUBLIC_IP=${aws_eip.web.public_ip} ./deploy.sh"
}