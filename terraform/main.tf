terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.25.0"
    }
  }
}

provider "google" {
  project = "gcp-practice-1-453919"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "allow-ssh" {
  name        = "allow-ssh"
  network     = google_compute_network.mynetwork.name
  description = "Allow SSH"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol  = "tcp"
    ports     = ["22"]
  }
}

resource "google_compute_firewall" "allow-web" {
  name        = "allow-web"
  network     = google_compute_network.mynetwork.name
  description = "Allow Web Traffic"
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol  = "tcp"
    ports     = ["80", "443"]
  }
}

resource "google_compute_instance" "web-test" {
  name         = "web-test"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io git
    sudo systemctl enable --now docker
  EOT

  metadata = {
    "ssh-keys" = "j_naeder324:${file("~/.ssh/gcp-ssh-key.pub")}"
  }

  network_interface {
    network = google_compute_network.mynetwork.name
    access_config {
    }
  }
}