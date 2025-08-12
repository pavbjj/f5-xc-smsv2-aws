resource "aws_security_group" "EC2-CE-sg-SLO" {
  name        = "${var.prefix}-sg-SLO"
  description = "Allow traffic flows on SLO, ingress and egress"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from trusted"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["104.219.108.84/32", "104.219.109.84/32"]
  }

  ingress {
    description = "ICMP from trusted"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["104.219.108.84/32", "104.219.109.84/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.prefix}-sg-SLO"
    owner = var.owner
  }
}

resource "aws_security_group" "EC2-CE-sg-SLI" {
  name        = "${var.prefix}-sg-SLI"
  description = "Allow traffic flows on SLI, ingress and egress"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.prefix}-sg-SLI"
    owner = var.owner
  }
}

resource "aws_network_interface" "public-1" {
  subnet_id         = var.slo_subnet_1
  security_groups   = [aws_security_group.EC2-CE-sg-SLO.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-pub-1"
    owner = var.owner
  }
}

resource "aws_network_interface" "public-2" {
  subnet_id         = var.slo_subnet_2
  security_groups   = [aws_security_group.EC2-CE-sg-SLO.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-pub-2"
    owner = var.owner
  }
}
resource "aws_network_interface" "public-3" {
  subnet_id         = var.slo_subnet_3
  security_groups   = [aws_security_group.EC2-CE-sg-SLO.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-pub-3"
    owner = var.owner
  }
}

resource "aws_network_interface" "private-1" {
  subnet_id         = var.sli_subnet_1
  security_groups   = [aws_security_group.EC2-CE-sg-SLI.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-priv-1"
    owner = "p-kuligowski"
  }
}

resource "aws_network_interface" "private-2" {
  subnet_id         = var.sli_subnet_2
  security_groups   = [aws_security_group.EC2-CE-sg-SLI.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-pri-2"
    owner = "p-kuligowski"
  }
}

resource "aws_network_interface" "private-3" {
  subnet_id         = var.sli_subnet_3
  security_groups   = [aws_security_group.EC2-CE-sg-SLI.id]
  source_dest_check = false
  tags = {
    Name  = "${var.prefix}-eni-priv-3"
    owner = "p-kuligowski"
  }
}

resource "aws_instance" "node-1" {
  depends_on    = [aws_security_group.EC2-CE-sg-SLI]
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.existing_ssh_key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.public-1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.private-1.id
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 80
  }

  user_data = data.cloudinit_config.f5xc-ce_config-node-1.rendered

  tags = {
    Name                                              = "${var.prefix}-node-1"
    "kubernetes.io/cluster/p-kuligowski-aws-smsv2-tf" = "owned"
  }
  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_instance" "node-2" {
  depends_on    = [aws_security_group.EC2-CE-sg-SLI]
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.existing_ssh_key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.public-2.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.private-2.id
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 80
  }

  user_data = data.cloudinit_config.f5xc-ce_config-node-2.rendered

  tags = {
    Name                                              = "${var.prefix}-node-2"
    "kubernetes.io/cluster/p-kuligowski-aws-smsv2-tf" = "owned"
  }
  lifecycle {
    ignore_changes = [user_data]
  }
}

resource "aws_instance" "node-3" {
  depends_on    = [aws_security_group.EC2-CE-sg-SLI]
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.existing_ssh_key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.public-3.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.private-3.id
  }
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 80
  }

  user_data = data.cloudinit_config.f5xc-ce_config-node-3.rendered

  tags = {
    Name                                              = "${var.prefix}-node-3"
    "kubernetes.io/cluster/p-kuligowski-aws-smsv2-tf" = "owned"
  }
  lifecycle {
    ignore_changes = [user_data]
  }
} 