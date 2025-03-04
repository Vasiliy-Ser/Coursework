# Application Load Balancer
resource "yandex_alb_target_group" "web_target_group" {
  name = "web-target-group"

  target {
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
    ip_address   = yandex_compute_instance.vm1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.private_subnet_b.id
    ip_address   = yandex_compute_instance.vm2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "web_backend_group" {
  name = "web-backend-group"

  http_backend {
    name             = "web-backend"
    port             = 80
    target_group_ids = [yandex_alb_target_group.web_target_group.id]

    healthcheck {
      timeout  = "1s"
      interval = "2s"

      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "web_http_router" {
  name = "web-http-router"
}

resource "yandex_alb_virtual_host" "web_virtual_host" {
  http_router_id = yandex_alb_http_router.web_http_router.id
  name           = "web-virtual-host"

  route {
    name = "web-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web_backend_group.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "web_load_balancer" {
  name = "web-load-balancer"

  network_id = data.yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.public_subnet_a.id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.private_subnet_b.id
    }
  }

  listener {
    name = "web-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web_http_router.id
      }
    }
  }
}