resource "aws_instance" "devops_ec2" {
  ami                         = var.ami  
  instance_type               = var.instance_type            
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "${var.Name}-EC2-Instance"
  }
}

resource "aws_security_group" "devops_sg" {
  name        = "${var.Name}-security-group"
  description = "Allow SSH and HTTP/HTTPS traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (restrict as needed)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "${var.Name}-security-group"
  }
}
