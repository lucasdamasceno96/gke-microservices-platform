# 1. Create a Service Account for GitHub Actions
resource "google_service_account" "github_actions" {
  account_id   = "github-actions-sa"
  display_name = "Service Account for GitHub Actions Pipeline"
}

# 2. Grant permissions to the Service Account
resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset([
    "roles/container.admin",              # To deploy to GKE
    "roles/compute.networkAdmin",         # To manage VPC
    "roles/storage.admin",                # To manage TF state bucket
    "roles/iam.workloadIdentityPoolAdmin" # To manage IAM if needed
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

# 3. Create the Workload Identity Pool
resource "google_iam_workload_identity_pool" "github_pool" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
  depends_on                = [google_project_service.enabled_apis] # Waiting for APIs
}

# 4. Create the Workload Identity Provider connected to GitHub
resource "google_iam_workload_identity_pool_provider" "github_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"
  display_name                       = "GitHub Actions Provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  # SECURITY: Only allow YOUR repository to authenticate
  attribute_condition = "assertion.repository == 'lucasdamasceno96/gke-microservices-platform'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# 5. Allow GitHub Actions to impersonate the Service Account
resource "google_service_account_iam_member" "github_impersonation" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_pool.name}/attribute.repository/lucasdamasceno96/gke-microservices-platform"
}
