# service account for terraform in CI/CD pipeline
resource "google_service_account" "ci-terraform" {
  account_id   = "ci-terraform"
  display_name = "ci-terraform"
  description  = "Service account for CI/CD pipeline"
  project      = var.project_id
}

resource "google_service_account_iam_member" "lilurl-iac-wiu" {
  service_account_id = google_service_account.ci-terraform.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/564701988502/locations/global/workloadIdentityPools/github-wif/attribute.repository/pansachin/lilurl-iac"
}

resource "google_project_iam_member" "project-owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.ci-terraform.email}"
}

# service account for lilurl service deployment
resource "google_service_account" "ci-lilurl" {
  account_id   = "ci-lilurl"
  display_name = "ci-lilurl"
  description  = "Service account for CI/CD pipeline"
  project      = var.project_id
}

resource "google_service_account_iam_member" "lilurl-wiu" {
  service_account_id = google_service_account.ci-lilurl.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/564701988502/locations/global/workloadIdentityPools/github-wif/attribute.repository/pansachin/lilurl"
}

resource "google_project_iam_member" "lilurl-access" {
  for_each = toset([
    "roles/compute.admin",
    "roles/artifactregistry.writer",
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.ci-lilurl.email}"
}
