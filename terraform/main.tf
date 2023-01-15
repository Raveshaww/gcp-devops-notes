terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.48.0"
    }
  }
}

provider "google" {
  project = "learninggke-374700"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  # You can call out a region or a zone, but just a zone allows us to limit the pool to 1 node
  location = "us-central1-c"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  # This let's us be absolutely sure that only one node will exist
  autoscaling {
    total_min_node_count = 1
    total_max_node_count = 1
  }

  node_config {
    preemptible  = true
    machine_type = "g1-small"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}