output "external_ip" {
    value = google_compute_instance.web-test.network_interface[0].access_config[0].nat_ip
}