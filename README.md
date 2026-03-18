# cbz-infraprovider
"aws" {
  region = "ap-south-1"   # Mumbai region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2 (update if needed)
  instance_type = "t2.micro"

  key_name = "my-keypair"   # Replace with your key pair name

  tags = {
    Name = "MyTerraformEC2"
  }
}
