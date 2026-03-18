provider "aws" {
  region = "eu-north-1"   
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-080254318c2d8932f"  
  instance_type = "t3.micro"

  tags = {
    Name = "MyTerraformEC2"
  }
}
