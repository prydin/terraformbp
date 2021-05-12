provider "aws" {
    version = "2.69.0"
    region="us-west-1"
}

variable "instance_type" {
  description = "AWS instance type"
  default     = "t2.micro"
}

variable "myTag" {
  description = "My Input Tag"
  default = "terraform-test"
}

varible "delay" {
  description = "Delay"
  default = "3600"
}

resource "aws_instance" "machine1" {
    ami           = "ami-0a63cd87767e10ed4"
    instance_type = "t2.micro"
    availability_zone = "us-west-1a"
    tags = {
      "type" = var.myTag
    }
}

resource "aws_instance" "machine2" {
    ami           = "ami-0a63cd87767e10ed4"
    instance_type = "t2.micro"
    availability_zone = "us-west-1a"
    tags = {
      "type" = var.myTag
    }
    provisioner "local-exec" {
        command = "echo 'Taking a nap'; sleep ${var.delay}"
    }
}

#resource "aws_network_interface_sg_attachment" "sg_attachment1" {
#  security_group_id    = "sg-8e01a2fb"
#  network_interface_id = "${aws_instance.machine1.primary_network_interface_id}"
#}

#resource "aws_network_interface_sg_attachment" "sg_attachment2" {
#  security_group_id    = "sg-aa750ddc"
#  network_interface_id = "${aws_instance.machine2.primary_network_interface_id}"
#}
