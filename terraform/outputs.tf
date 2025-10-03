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