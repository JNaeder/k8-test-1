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
    ports     = ["80", "443", "8000"]
  }
}

resource "google_compute_instance" "web-test" {
  name         = "web-test"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20250313"
    }
  }

  metadata = {
    "ssh-keys" = "j_naeder324:${file("~/.ssh/gcp-ssh-key.pub")}"
  }

  network_interface {
    network = google_compute_network.mynetwork.name
    access_config {
    }
  }

  # Startup script to write external IP to .env file
  metadata_startup_script = <<-EOT
    #!/bin/bash
    EXTERNAL_IP=$(curl -s http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip -H "Metadata-Flavor: Google")
    echo "EXTERNAL_IP=$EXTERNAL_IP" > /home/j_naeder324/.env.production
    chown j_naeder324:j_naeder324 /home/j_naeder324/.env.production
  EOT
}