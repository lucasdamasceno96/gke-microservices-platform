output "gcp_service_account_email" {
  description = "The email of the Service Account for GitHub Actions"
  value       = google_service_account.github_actions.email
}

output "workload_identity_provider_name" {
  description = "The full name of the Workload Identity Provider"
  value       = google_iam_workload_identity_pool_provider.github_provider.name
}

output "gke_cluster_name" {
  description = "The name of the GKE cluster"
  value       = google_container_cluster.primary.name
}
