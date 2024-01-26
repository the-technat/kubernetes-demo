output "ns_records" {
    value = aws_route53_zone.primary.name_servers
    description = "NS records for you to add"
}