aws_region           = "us-east-1"
origin_domain_name   = "my-bucket.s3.amazonaws.com"
origin_id            = "myS3Origin"
default_cache_behavior = {
  viewer_protocol_policy = "redirect-to-https"
  allowed_methods        = ["GET", "HEAD", "OPTIONS"]
  cached_methods         = ["GET", "HEAD"]
  compress               = true
  min_ttl                = 0
  default_ttl            = 3600
  max_ttl                = 86400
  forwarded_values = {
    query_string = false
    cookies = {
      forward = "none"
    }
  }
}
certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/abcd1234-efgh-5678-ijkl-9012mnop3456"
waf_web_acl_id  = "arn:aws:wafv2:us-east-1:123456789012:global/webacl/ExampleWebACL/abcd1234-efgh-5678-ijkl-9012mnop3456"
log_bucket      = "my-cloudfront-logs"
tags = {
  Environment = "production"
  Project     = "example-project"
}
