output "aws_lb_dns" {
  value = aws_lb.nginx.dns_name

}