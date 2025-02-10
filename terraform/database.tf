resource "google_sql_database_instance" "database_instance" {
  depends_on = [google_project_service.services, google_service_networking_connection.private_network_connection]

  name                = "hackathon-database-instance"
  database_version    = "MYSQL_8_0"
  deletion_protection = false
  region              = local.google.region
  project             = local.google.project

  settings {
    tier                        = "db-f1-micro"
    edition                     = "ENTERPRISE"
    disk_size                   = "10"
    disk_autoresize             = false
    deletion_protection_enabled = true

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.network.self_link
    }
  }
}

resource "google_sql_database" "monolith_database" {
  name     = "monolith"
  instance = google_sql_database_instance.database_instance.name
}

resource "random_password" "monolith_database_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "google_sql_user" "monolith_database_user" {
  name     = "monolith"
  instance = google_sql_database_instance.database_instance.name
  host     = "%"
  password = random_password.monolith_database_password.result
}

resource "google_sql_database" "worker_database" {
  name     = "worker"
  instance = google_sql_database_instance.database_instance.name
}

resource "random_password" "worker_database_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "google_sql_user" "worker_database_user" {
  name     = "worker"
  instance = google_sql_database_instance.database_instance.name
  host     = "%"
  password = random_password.worker_database_password.result
}

output "monolith_database_instance" {
  value = google_sql_database_instance.database_instance.name
}
