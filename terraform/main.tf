terraform {
  cloud {
    organization = "jnaeder"

    workspaces {
      name = "k8-test-1"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.25.0"
    }
  }
}

variable "project_id" {}
variable "external_ip" {}
variable "region" {}
variable "zone" {}
variable "domain_name" {}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# resource "google_compute_network" "mynetwork" {
#   name                    = "mynetwork"
#   auto_create_subnetworks = true
# }


# resource "google_compute_firewall" "allow-web" {
#   name          = "allow-web"
#   network       = google_compute_network.mynetwork.name
#   description   = "Allow Web Traffic"
#   source_ranges = ["0.0.0.0/0"]

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "443"]
#   }
# }

# resource "google_container_cluster" "my-cluster" {
#   name                = "my-cluster"
#   deletion_protection = false
#   enable_autopilot    = true
#   network             = google_compute_network.mynetwork.name
# }

resource "google_dns_managed_zone" "audiobytes-zone" {
  name        = "audiobytes"
  dns_name    = "audiobytes.app."
}

resource "google_dns_record_set" "a-record" {
  name         = var.domain_name
  managed_zone = google_dns_managed_zone.audiobytes-zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [var.external_ip]
}

