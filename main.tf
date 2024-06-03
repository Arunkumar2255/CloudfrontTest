resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = var.origin_domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront distribution for ${var.origin_domain_name}"
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = var.origin_id
    viewer_protocol_policy = var.default_cache_behavior.viewer_protocol_policy
    allowed_methods        = var.default_cache_behavior.allowed_methods
    cached_methods         = var.default_cache_behavior.cached_methods
    compress               = var.default_cache_behavior.compress
    min_ttl                = var.default_cache_behavior.min_ttl
    default_ttl            = var.default_cache_behavior.default_ttl
    max_ttl                = var.default_cache_behavior.max_ttl

    forwarded_values {
      query_string = var.default_cache_behavior.forwarded_values.query_string

      cookies {
        forward = var.default_cache_behavior.forwarded_values.cookies.forward
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
    cloudfront_default_certificate = false
  }

  logging_config {
    include_cookies = false
    bucket          = "${var.log_bucket}.s3.amazonaws.com"
    prefix          = "cloudfront-logs/"
  }

  web_acl_id = var.waf_web_acl_id

  tags = merge({
    Name = "main-cloudfront-distribution"
  }, var.tags)
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = var.log_bucket
  acl    = "log-delivery-write"
  tags   = var.tags
}

resource "aws_wafv2_web_acl" "example" {
  name        = "example"
  description = "Example WAF"
  scope       = "CLOUDFRONT"
  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "example"
    sampled_requests_enabled   = true
  }

  tags = var.tags
}

