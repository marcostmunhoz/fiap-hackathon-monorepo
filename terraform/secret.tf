resource "google_secret_manager_secret" "preset_secrets" {
  depends_on = [google_project_service.services]
  for_each   = var.secrets

  secret_id = each.key
  project   = local.google.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "preset_secret_versions" {
  for_each = var.secrets

  secret      = google_secret_manager_secret.preset_secrets[each.key].id
  secret_data = each.value
}


resource "google_secret_manager_secret" "db_host_secret" {
  depends_on = [google_project_service.services]

  secret_id = "HACKATHON_DB_HOST"
  project   = local.google.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_host_secret_version" {
  secret      = google_secret_manager_secret.db_host_secret.id
  secret_data = google_sql_database_instance.database_instance.private_ip_address
}

resource "google_secret_manager_secret" "monolith_db_password_secret" {
  depends_on = [google_project_service.services]

  secret_id = "HACKATHON_MONOLITH_DB_PASSWORD"
  project   = local.google.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "monolith_db_password_secret_version" {
  secret      = google_secret_manager_secret.monolith_db_password_secret.id
  secret_data = random_password.monolith_database_password.result
}

resource "google_secret_manager_secret" "worker_db_password_secret" {
  depends_on = [google_project_service.services]

  secret_id = "HACKATHON_WORKER_DB_PASSWORD"
  project   = local.google.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "worker_db_password_secret_version" {
  secret      = google_secret_manager_secret.worker_db_password_secret.id
  secret_data = random_password.worker_database_password.result
}

resource "google_secret_manager_secret" "application_service_account_key_secret" {
  depends_on = [google_project_service.services]

  secret_id = "HACKATHON_APPLICATION_SERVICE_ACCOUNT_KEY"
  project   = local.google.project
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "application_service_account_key_secret_version" {
  secret      = google_secret_manager_secret.application_service_account_key_secret.id
  secret_data = base64decode(google_service_account_key.service_account_key.private_key)
}
