terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "terraform-project-440408"
  region  = "eu-north1"
}

resource "google_compute_network" "exercise3-vpc" {
  project                 = "terraform-project-440408"
  name                    = "exercise3-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_instance" "exercise3-vm" {
  name         = "exercise3-vm"
  machine_type = "n2-standard-2"
  zone         = "europe-north1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.exercise3-vpc.name
  }
  metadata_startup_script = "echo hi > /file"
}

resource "google_compute_firewall" "exercise3-firewall" {
  name    = "exercise3-firewall"
  network = google_compute_network.exercise3-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_tags = ["web"]
}
