resource "google_storage_bucket" "storage_bucket" {
  name                        = "fiap-pos-graduacao-hackathon-bucket"
  location                    = local.google.location
  force_destroy               = true
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = false
}
