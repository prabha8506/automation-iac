# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}
output "zones" {
    value = data.aws_availability_zones.available.names
  
}

output "vpcid" {
    value = aws_vpc.vpc.id
  
}