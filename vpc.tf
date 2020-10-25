
# deploying VPC, using deploy_env variable to allow multiple environments to run side-by-side.
resource "google_compute_network" "vpc" {
  name = "test-code-network1-${var.deploy_env}"
  auto_create_subnetworks = "false"
}

# deploying subnet.

resource "google_compute_subnetwork" "subnet" {
  name          = "${google_compute_network.vpc.name}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.11.0.0/24"

}

