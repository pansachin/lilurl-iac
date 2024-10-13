resource "google_service_account" "ci-terraform" {
    account_id = "ci-terraform"
    display_name = "ci-terraform"
    description = "Service account for CI/CD pipeline"
    project = var.project_id
}

resource "google_service_account_iam_member" "lilurl-iac-wiu" {
  service_account_id = google_service_account.ci-terraform.name
  role = "roles/iam.workloadIdentityUser"
  member = "principal://iam.googleapis.com/projects/564701988502/locations/global/workloadIdentityPools/github-wif/subject/pansachin/lilurl-iac"
}

resource "google_project_iam_member" "project-owner" {
  project = var.project_id
  role = "roles/owner"
  member = "serviceAccount:${google_service_account.ci-terraform.email}"
}