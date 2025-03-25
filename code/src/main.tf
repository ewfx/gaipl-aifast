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

data "google_storage_project_service_account" "gcs_account" {
}


resource "google_kms_crypto_key_iam_member" "gcs_crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  member = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"

}

resource "google_storage_bucket" "hackathon2025_datasets" {
    depends_on = [ google_kms_crypto_key_iam_member.gcs_crypto_key ]
  project = "mythic-guild-454407-r6"
  name          = "hackathon2025_datasets"
  location      = "us-central1"
  force_destroy = true
  
  encryption {
    default_kms_key_name = google_kms_crypto_key.crypto_key.id
  }
  public_access_prevention = "enforced"
}

data "google_project" "google_project" {
    project_id = "mythic-guild-454407-r6"
}

#this is to enable robo account of biqguery
data "google_bigquery_default_service_account" "bq_sa" {
    project = "mythic-guild-454407-r6"
}

resource "google_kms_crypto_key_iam_member" "bq_crypto_key" {
  crypto_key_id = google_kms_crypto_key.key.id
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  member  = "serviceAccount:bq-${data.google_project.google_project.number}@bigquery-encryption.iam.gserviceaccount.com"

}

# resource "google_project_iam_member" "project" {
#     depends_on = [ data.google_bigquery_default_service_account.bq_sa ]
#   project = "mythic-guild-454407-r6"
#   role    = "roles/cloudkms.cryptoKeyEncrypter"
#   member  = "serviceAccount:bq-${data.google_project.google_project.number}@bigquery-encryption.iam.gserviceaccount.com"
# }


resource "google_bigquery_dataset" "dataset" {
    depends_on = [ google_kms_crypto_key_iam_member.bq_crypto_key ]
  dataset_id                  = "example_dataset"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "US"
  #   default_table_expiration_ms = 3600000

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


#data store
resource "google_discovery_engine_data_store" "test_data_store" {
  location                    = "us"
  data_store_id               = "data-store"
  display_name                = "Structured datastore"
  industry_vertical           = "GENERIC"
  content_config              = "NO_CONTENT"
  solution_types              = ["SOLUTION_TYPE_CHAT"]
}

resource "google_discovery_engine_data_store" "test_data_store_2" {
  location                    = google_discovery_engine_data_store.test_data_store.location
  data_store_id               = "data-store-2"
  display_name                = "Structured datastore 2"
  industry_vertical           = "GENERIC"
  content_config              = "NO_CONTENT"
  solution_types              = ["SOLUTION_TYPE_CHAT"]
}

#agent builder chat engine
resource "google_discovery_engine_chat_engine" "primary" {
  engine_id = "chat-engine-id"
  collection_id = "default_collection"
  location = google_discovery_engine_data_store.test_data_store.location
  display_name = "Chat engine"
  industry_vertical = "GENERIC"
  data_store_ids = [google_discovery_engine_data_store.test_data_store.data_store_id, google_discovery_engine_data_store.test_data_store_2.data_store_id]
  common_config {
    company_name = "hack-ipe-company"
  }
  chat_engine_config {
    agent_creation_config {
    business = "test business name"
    default_language_code = "en"
    time_zone = "America/Los_Angeles"
    }
  }
}