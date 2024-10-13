variable "project_id" {
  description = "ID of google project"
  type        = string
}

variable "region" {
  description = "Default region for resources"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Name of the bucket"
  type        = string
}

variable "zone" {
  description = "Default zone for resources"
  type        = string
  default     = "us-central1-c"
}
