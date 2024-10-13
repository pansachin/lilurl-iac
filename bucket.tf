resource "google_storage_bucket" "tf-state-bucket" {
  name          = var.bucket_name
  force_destroy = true
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}