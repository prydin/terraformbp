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

resource "null_resource" "install_python" {
  provisioner "local-exec" {
    command = "apk add --no-cache python3 py3-pip; python3 -c 'print(\"Python successfully installed!\")'"
  }
  triggers = {
    always_run = timestamp()
  }
}

resource "aws_instance" "machine1" {
  ami           = "ami-0a63cd87767e10ed4"
  instance_type = "t2.micro"
  tags = {
    "type" = var.myTag
  }
  provisioner "local-exec" {
    command = "python3 -c print('Python is accessible from resource provisioning!')"
 }
  depends_on = [ null_resource.install_python ]
}

