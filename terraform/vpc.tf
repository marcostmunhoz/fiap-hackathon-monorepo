resource "google_compute_network" "network" {
  depends_on = [google_project_service.services]

  name                    = "fiap-pos-graduacao-hackathon-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnetwork" {
  depends_on = [google_compute_network.network]

  region        = local.google.region
  name          = "fiap-pos-graduacao-hackathon-subnetwork"
  network       = google_compute_network.network.name
  ip_cidr_range = "10.2.0.0/24"
}

resource "google_compute_global_address" "cloud_sql_private_id" {
  name          = "fiap-hackathon-cloud-sql-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  ip_version    = "IPV4"
  prefix_length = 16
  network       = google_compute_network.network.name
}

resource "google_service_networking_connection" "private_network_connection" {
  network                 = google_compute_network.network.name
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.cloud_sql_private_id.name]
}

output "network" {
  value = google_compute_network.network.name
}

output "subnetwork" {
  value = google_compute_subnetwork.subnetwork.name
}
