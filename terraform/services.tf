# ----------------------------------------------------------------------------------
# WHY: APIs in GCP are disabled by default. 
# We manage them as resources to ensure the project is self-contained.
# ----------------------------------------------------------------------------------

variable "gcp_service_list" {
  description = "The list of apis necessary for the project"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sts.googleapis.com", # Required for Workload Identity
  ]
}

resource "google_project_service" "enabled_apis" {
  for_each = toset(var.gcp_service_list)
  project  = var.project_id
  service  = each.key

  # Set to false to prevent accidental disabling of APIs that might have 
  # other resources attached if you destroy the module.
  disable_on_destroy = false
}
