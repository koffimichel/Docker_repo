#data for amazon linux
data "aws_ami" "amazon-2" {
    most_recent = true
  
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    }
    owners = ["amazon"]
  }

# create ec2

resource "aws_instance" "serv1" {
  instance_type = "t2.micro"
  ami = data.aws_ami.amazon-2.id
  key_name = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data = file("code.sh")
  tags = {
    Name = "Docker-web"
    Team = "Cloud"
  }
}
#create ebs volume

resource "aws_ebs_volume" "vol1" {
  availability_zone = aws_instance.serv1.availability_zone
  size = 10
  tags= {
    Name = "devvolume"
    Team = "cloud"
  }
}
#attach volume 
resource "aws_volume_attachment" "name" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.vol1.id
  instance_id = aws_instance.serv1.id
}


