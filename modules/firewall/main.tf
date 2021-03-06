resource "google_compute_firewall" "allow-http" {
  name    = "${var.network}-allow-http"
  network = var.network
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["80","8080"]
  }

  target_tags   = ["${var.network}-allow-http"]
  source_ranges = ["0.0.0.0/0"]
}

# IAP: identity aware proxy firewall rule.
resource "google_compute_firewall" "allow-ingress-from-iap" {
  name    = "${var.network}-allow-ingress-from-iap"
  network = var.network
  project = var.project

  direction = "INGRESS"
  priority  = 1000

  # Cloud IAP's TCP forwarding netblock
  target_tags   = ["iap-tunnel"]
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}

# Temp Solution for Developers (i.e Kavi, this should be removed)
resource "google_compute_firewall" "allow-ssh-rdp" {
  name    = "${var.network}-allow-ssh-rdp"
  network = var.network
  project = var.project

  direction = "INGRESS"
  priority  = 1000

  # Cloud IAP's TCP forwarding netblock
  target_tags   = ["${var.network}-allow-ssh-rdp"]
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}
