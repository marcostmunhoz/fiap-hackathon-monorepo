resource "google_service_account" "service_account" {
  account_id   = "hackathon-application-sa"
  display_name = "Hackathon Application Service Account"
}

resource "google_project_iam_binding" "service_account_binding" {
  for_each = toset([
    "roles/pubsub.publisher",
    "roles/pubsub.subscriber",
    "roles/storage.objectUser",
    "roles/secretmanager.secretAccessor",
  ])

  project = local.google.project
  role    = each.value
  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}

resource "google_service_account_key" "service_account_key" {
  service_account_id = google_service_account.service_account.id
}

output "service_account_id" {
  value = google_service_account.service_account.id
}
