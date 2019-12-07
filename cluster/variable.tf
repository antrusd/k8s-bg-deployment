variable "ANTRUSD_SA" {
}

variable "cluster_name" {
    default = "antrusd-gke-01"
}

variable "cluster_version" {
    default = "1.12.10-gke.20"
}

variable "region" {
    default = "asia-southeast1"
}

variable "project" {
    default = "antrusd-project-id"
}

variable "worker_spec" {
    default = "custom-2-2048"
}

variable "worker_disk" {
    default = "60"
}

variable "worker_count" {
    default = "1"
}

variable "vpc" {
    default = "antrusd-personal-vpc"
}

variable "subnet" {
    default = "antrusd-personal-subnet"
}

data "google_client_config" "default" {
}

data "template_file" "kubeconfig" {
    template = file("${path.module}/kubeconfig-template.yaml")

    vars = {
        cluster_name    = google_container_cluster.primary.name
        endpoint        = google_container_cluster.primary.endpoint
        token           = data.google_client_config.default.access_token
        cluster_ca      = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
    }
}
