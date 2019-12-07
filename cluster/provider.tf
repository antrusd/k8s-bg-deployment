provider "google" {
    credentials = "${file("${var.ANTRUSD_SA}")}"
    project     = var.project
    region      = var.region
}
