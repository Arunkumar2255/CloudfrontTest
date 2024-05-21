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

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {
    Environment = "production"
    Project     = "example-project"
  }
}
