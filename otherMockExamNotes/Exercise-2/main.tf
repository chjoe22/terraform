# Specify the Google provider
provider "google" {
  project = "YOUR_PROJECT_ID"
  region  = "europe-north1"
  zone    = "europe-north1-a"
}

# Step 1: Create a non-default auto mode VPC network
resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc-network"
  auto_create_subnetworks = true  # Auto mode network
}

# Step 2: Create a VM instance in a subnet related to europe-north1
resource "google_compute_instance" "vm_instance" {
  name         = "example-vm-instance"
  machine_type = "e2-micro"
  zone         = "europe-north1-a"

  # Define the VM instance's network interface, connecting it to the VPC
  network_interface {
    network = google_compute_network.custom_vpc.id

    # Automatically create an ephemeral public IP for SSH and HTTP access
    access_config {}
  }

  # Use a basic Debian image
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  tags = ["http-server"]
}

# Step 3: Create a firewall rule that allows HTTP traffic to the VM instance
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.custom_vpc.id

  # Allow ingress on port 80 for HTTP traffic
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Apply rule to instances with the "http-server" tag
  target_tags = ["http-server"]

  # Allow traffic from any IP address
  source_ranges = ["0.0.0.0/0"]
}
