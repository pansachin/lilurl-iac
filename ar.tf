resource "google_artifact_registry_repository" "lilurl" {
  location      = "us-central1"
  repository_id = "lilurl"
  description   = "Lilurl repository"
  format        = "DOCKER"
}
