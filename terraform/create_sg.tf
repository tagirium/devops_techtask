resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "security group"
//  ingress {
//    from_port   = 0
//    to_port     = 65535
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  egress {
//    from_port   = 0
//    to_port     = 65535
//    protocol    = "tcp"
//    cidr_blocks = ["0.0.0.0/0"]
//  }

  ingress {
    description      = "My public IP"
    protocol         = var.sg_ingress_proto_tcp
    from_port        = var.sg_ingress_all_start_tcp
    to_port          = var.sg_ingress_all_end_tcp
  }

  ingress {
    description = "SSH"
    from_port = var.sg_ingress_ssh
    protocol = var.sg_ingress_proto_ssh
    to_port = var.sg_ingress_ssh
  }


  egress {
    description      = "All traffic"
    protocol         = var.sg_egress_proto
    from_port        = var.sg_egress_all
    to_port          = var.sg_egress_all
    cidr_blocks      = [var.sg_egress_cidr_block]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  }

  tags = {
    "Owner" = var.owner
    "Name"  = "${var.owner}-sg"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "terra"
  public_key = file(var.public_key)
}