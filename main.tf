terraform {
  required_version = ">=1.3.0, < 1.6.0"

  backend "gcs" {
    bucket  = "tf-state-bucket-438113"
    prefix  = "/lilurl/state"
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
