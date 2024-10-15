# service account for terraform in CI/CD pipeline
resource "google_service_account" "ci-terraform" {
  account_id   = "ci-terraform"
  display_name = "ci-terraform"
  description  = "Service account for CI/CD pipeline"
  project      = var.project_id
}

resource "google_service_account_iam_member" "lilurl-iac-wiu" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    # "roles/iam.serviceAccountOpenIdTokenCreator",
    # "roles/iam.serviceAccountTokenCreator"
  ])

  service_account_id = google_service_account.ci-terraform.name
  role               = each.value
  member             = "principalSet://iam.googleapis.com/projects/564701988502/locations/global/workloadIdentityPools/github-wif/attribute.repository/pansachin/lilurl-iac"
}

resource "google_project_iam_member" "project-owner" {
  project = var.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.ci-terraform.email}"
}

# service account for service deployment
resource "google_service_account" "ci-lilurl" {
  account_id   = "ci-lilurl"
  display_name = "ci-lilurl"
  description  = "Service account for CI/CD pipeline"
  project      = var.project_id
}

resource "google_service_account_iam_member" "lilurl-wiu" {
  for_each = toset([
    "roles/iam.workloadIdentityUser",
    # "roles/iam.serviceAccountOpenIdTokenCreator",
    # "roles/iam.serviceAccountTokenCreator"
  ])
  service_account_id = google_service_account.ci-lilurl.name
  role               = each.value
  member             = "principalSet://iam.googleapis.com/projects/564701988502/locations/global/workloadIdentityPools/github-wif/attribute.repository/pansachin/lilurl"
}

resource "google_project_iam_member" "lilurl-access" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.ci-lilurl.email}"
}