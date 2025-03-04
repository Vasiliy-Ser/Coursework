# Создание ежедневных снимков для всех виртуальных машин
resource "yandex_compute_snapshot_schedule" "vm1_snapshot_schedule" {
  name           = "vm1-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for VM1"
  }
  disk_ids = [yandex_compute_instance.vm1.boot_disk.0.disk_id]
}

resource "yandex_compute_snapshot_schedule" "vm2_snapshot_schedule" {
  name           = "vm2-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for VM2"
  }
  disk_ids = [yandex_compute_instance.vm2.boot_disk.0.disk_id]
}

resource "yandex_compute_snapshot_schedule" "prometheus_snapshot_schedule" {
  name           = "prometheus-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for Prometheus VM"
  }
  disk_ids = [yandex_compute_instance.prometheus_vm.boot_disk.0.disk_id]
}

resource "yandex_compute_snapshot_schedule" "grafana_snapshot_schedule" {
  name           = "grafana-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for Grafana VM"
  }
  disk_ids = [yandex_compute_instance.grafana_vm.boot_disk.0.disk_id]
}

resource "yandex_compute_snapshot_schedule" "elasticsearch_snapshot_schedule" {
  name           = "elasticsearch-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for Elasticsearch VM"
  }
  disk_ids = [yandex_compute_instance.elasticsearch_vm.boot_disk.0.disk_id]
}

resource "yandex_compute_snapshot_schedule" "kibana_snapshot_schedule" {
  name           = "kibana-snapshot-schedule"
  schedule_policy {
    expression = "0 1 * * *"  # Ежедневно в 1:00
  }
  snapshot_count = 7  # Ограничение времени жизни снапшотов до одной недели
  snapshot_spec {
    description = "Daily snapshot for Kibana VM"
  }
  disk_ids = [yandex_compute_instance.kibana_vm.boot_disk.0.disk_id]
}
