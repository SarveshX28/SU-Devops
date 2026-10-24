output "instance_id" {
  value       = aws_instance.lab.id
  description = "Created EC2 instance ID."
}

output "public_ip" {
  value       = aws_instance.lab.public_ip
  description = "Public IPv4 address of the EC2 instance."
}

output "ssh_command" {
  value       = "ssh -i <path-to-private-key> ubuntu@${aws_instance.lab.public_ip}"
  description = "Replace the key path with your local private key path."
}
