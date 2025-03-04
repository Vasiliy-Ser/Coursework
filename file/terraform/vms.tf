# Bastion Host
resource "yandex_compute_instance" "bastion" {
  name = "bastion-host"
  zone = "ru-central1-a"

  resources {
    memory = 2
    cores  = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet_a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
  }

  # Сетевой интерфейс для приватной подсети A
  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.bastion_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

# Web Servers
resource "yandex_compute_instance" "vm1" {
  name = "web-server-1"
  zone = "ru-central1-a"

  resources {
    memory = 2
    cores  = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

resource "yandex_compute_instance" "vm2" {
  name = "web-server-2"
  zone = "ru-central1-b"

  resources {
    memory = 2
    cores  = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet_b.id
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

# Prometheus Server
resource "yandex_compute_instance" "prometheus_vm" {
  name = "prometheus-server"
  zone = "ru-central1-a"

  resources {
    memory        = 2
    cores         = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

# Grafana Server
resource "yandex_compute_instance" "grafana_vm" {
  name = "grafana-server"
  zone = "ru-central1-a"

  resources {
    memory        = 2
    cores         = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet_a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.public_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

# Elasticsearch Server
resource "yandex_compute_instance" "elasticsearch_vm" {
  name = "elasticsearch-server"
  zone = "ru-central1-a"

  resources {
    memory = 2
    cores  = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
      size     = 20 
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}

# Kibana Server
resource "yandex_compute_instance" "kibana_vm" {
  name = "kibana-server"
  zone = "ru-central1-a"

  resources {
    memory = 2
    cores  = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "fd83s8u085j3mq231ago"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet_a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.public_sg.id]
  }

  metadata = {
    user-data = "${file("~/test/meta.txt")}"
  }

  scheduling_policy { preemptible = true }

}
