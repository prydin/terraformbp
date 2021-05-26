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

# Dummy resource that runs a provisioner to install Python. Make sure
# resources needing Python declare this as a "depends_on".
resource "null_resource" "install_python" {
  provisioner "local-exec" {
    command = "apk add --no-cache python3 py3-pip; python3 -c 'print(\"Python successfully installed!\")'"
  }

  # This is a trick to make sure the installation runs regardless of the 
  # type of operation.
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
  
  # Test that python is indeed available. Replace this with whatever Python code you
  # need to run.
  provisioner "local-exec" {
    command = "python3 -c 'print(\"Python is accessible from resource provisioning!\")'"
 }
  # Makes sure Python is installed before we provision
  depends_on = [ null_resource.install_python ]
}

