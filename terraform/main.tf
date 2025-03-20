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

  # metadata_startup_script = <<-EOT
  #   #! /bin/bash

    # Add Docker's official GPG key:
    # sudo apt-get update
    # sudo apt-get install ca-certificates curl
    # sudo install -m 0755 -d /etc/apt/keyrings
    # sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    # sudo chmod a+r /etc/apt/keyrings/docker.asc

    # # Add the repository to Apt sources:
    # echo \
    #   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    #   $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    #   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # sudo apt-get update

    # sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git -y

    # git clone https://github.com/JNaeder/k8-test-1.git
    # cd /home/j_naeder324/k8-test-1

    # sudo docker compose up --detach

  # EOT

  metadata = {
    "ssh-keys" = "j_naeder324:${file("~/.ssh/gcp-ssh-key.pub")}"
  }

  network_interface {
    network = google_compute_network.mynetwork.name
    access_config {
    }
  }
}