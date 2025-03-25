#enabling apis
resource "google_project_service" "project" {
  project = "mythic-guild-454407-r6"
  for_each = toset(["bigquery.googleapis.com","aiplatform.googleapis.com","discoveryengine.googleapis.com","storage.googleapis.com"])
  service = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}


resource "google_storage_bucket" "hackathon2025_datasets" {
  name          = "hackathon2025_datasets"
  location      = "us-central1"
  force_destroy = true
  
  encryption {
    default_kms_key_name = google_kms_crypto_key.crypto_key.id
  }
  public_access_prevention = "enforced"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "US"
  default_table_expiration_ms = 3600000

  default_encryption_configuration {
    kms_key_name = google_kms_crypto_key.crypto_key.id
  }
}

resource "google_kms_crypto_key" "crypto_key" {
  name     = "hack-key"
  key_ring = google_kms_key_ring.key_ring.id
}

resource "google_kms_key_ring" "key_ring" {
  name     = "hack-keyring"
  location = "us-central1"
}
