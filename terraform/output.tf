output "ec2_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.testinstance.arn
}

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.testinstance.public_ip
}