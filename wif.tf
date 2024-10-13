resource "google_iam_workload_identity_pool" "github-wif-pool" {
  workload_identity_pool_id = "github-wif"
  project = var.project_id
  display_name = "github-wif"
}

resource "google_iam_workload_identity_pool_provider" "github-provider" {
  workload_identity_pool_id = google_iam_workload_identity_pool.github-wif-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name = "github-provider"
  description = "Github provider"
  attribute_condition = "assertion.repository_owner == 'pansachin'"
  attribute_mapping = {
    "google.subject" = "assertion.sub"
    "attribute.actor" = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
    allowed_audiences = ["https://github.com/pansachin"]
  }
}