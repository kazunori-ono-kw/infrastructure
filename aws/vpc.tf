resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr[var.env]
    enable_dns_hostnames = true
    tags = {
        Name = "${var.env}-${var.project}-vpc"
    }
}

resource "aws_subnet" "public_a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet_cidr["${var.env}_public_a"]
    availability_zone = var.az["az_a"]
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.env}-${var.project}-public-a-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.env}-${var.project}-igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.env}-${var.project}-public-rtb"
    }
}

resource "aws_route_table_association" "public_a" {
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "kubeec2" {
  vpc_id = aws_vpc.vpc.id
  name   = "kubeec2"

  tags = {
    Name = "kubeec2"
  }
}

# インバウンドルール(ssh接続用)
resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.kubeec2.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
}

# インバウンドルール(pingコマンド用)
resource "aws_security_group_rule" "in_icmp" {
  security_group_id = aws_security_group.kubeec2.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
}

# アウトバウンドルール(全開放)
resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.kubeec2.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
}