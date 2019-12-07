resource "google_container_cluster" "primary" {
    name               = var.cluster_name
    location           = var.region

    network            = var.vpc
    subnetwork         = var.subnet

    private_cluster_config {
        enable_private_endpoint = false
        enable_private_nodes    = true
        master_ipv4_cidr_block  = "10.10.10.0/28"
    }

    master_auth {
    }

    ip_allocation_policy {
    }

    node_pool {
        name       = "${var.cluster_name}-nodes"
        node_count = var.worker_count

        node_config {
            preemptible  = true
            machine_type = var.worker_spec
            disk_size_gb = var.worker_disk

            metadata = {
                disable-legacy-endpoints = true
            }

            oauth_scopes = [
                "cloud-platform",
            ]
        }
    }

    min_master_version = var.cluster_version
    node_version       = var.cluster_version
}

resource "local_file" "kubeconfig" {
    content              = data.template_file.kubeconfig.rendered
    filename             = "${path.module}/kubeconfig"
    directory_permission = "0755"
    file_permission      = "0644"
}
