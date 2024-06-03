variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "origin_domain_name" {
  description = "The domain name of the origin"
  type        = string
}

variable "origin_id" {
  description = "The origin ID for the CloudFront distribution"
  type        = string
}

variable "default_cache_behavior" {
  description = "Default cache behavior settings"
  type        = any
}

variable "certificate_arn" {
  description = "The ARN of the ACM SSL certificate"
  type        = string
}

variable "waf_web_acl_id" {
  description = "The ID of the WAF web ACL"
  type        = string
}

variable "log_bucket" {
  description = "The S3 bucket for CloudFront access logs"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {
    Environment = "production"
    Project     = "example-project"
  }
}
