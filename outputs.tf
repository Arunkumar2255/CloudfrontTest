output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.main.id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.main.domain_name
}

output "waf_web_acl_arn" {
  description = "The ARN of the WAF web ACL"
  value       = aws_wafv2_web_acl.example.arn
}
