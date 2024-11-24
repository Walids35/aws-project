# Define the Elastic IP resource
resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = {
    Name = "MyElasticIP" # You can replace "MyElasticIP" with your desired tag value
  }
}
