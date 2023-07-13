terraform {
  backend "gcs" {
    bucket = "meshcloud-tf-states"
    prefix = "meshcloud-prod/collie-hub/amplify"
  }
}