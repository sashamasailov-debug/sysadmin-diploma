terraform {
  required_version = ">= 1.6"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.140"
    }
  }
}

provider "yandex" {
  service_account_key_file = "C:/Users/Sasha/Desktop/yc-key/authorized_key.json"

  cloud_id  = "b1gsku7td22n58hs2o66"
  folder_id = "b1g5rnrcmq5c035145tu"

  zone = "ru-central1-a"
}