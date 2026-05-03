# 1. VPC & Subnet
resource "google_compute_network" "vpc" {
  name                    = "gke-vpc"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.enabled_apis] # Waiting APIs
}

resource "google_compute_subnetwork" "subnet" {
  name          = "gke-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.0.0.0/16"
}

# 2. GKE Autopilot Cluster
resource "google_container_cluster" "primary" {
  name     = "online-boutique-cluster"
  location = var.region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  # Enable Autopilot for frictionless management
  enable_autopilot = true

  # Deletion protection set to false for portfolio tear-down
  deletion_protection = false
}
