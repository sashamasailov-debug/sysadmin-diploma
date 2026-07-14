resource "yandex_alb_target_group" "web" {
  name = "web-target-group"

  target {
    subnet_id  = yandex_vpc_subnet.private_a.id
    ip_address = yandex_compute_instance.web1.network_interface[0].ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.private_d.id
    ip_address = yandex_compute_instance.web2.network_interface[0].ip_address
  }
}
resource "yandex_alb_backend_group" "web" {
  name = "web-backend-group"

  http_backend {
    name             = "web-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.web.id]

    load_balancing_config {
      panic_threshold = 50
    }

    healthcheck {
      timeout  = "1s"
      interval = "3s"

      http_healthcheck {
        path = "/"
      }
    }
  }
}
resource "yandex_alb_http_router" "web" {
  name = "web-router"
}
resource "yandex_alb_virtual_host" "web" {
  name           = "web-host"
  http_router_id = yandex_alb_http_router.web.id

  route {
    name = "default"

    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web.id
        timeout          = "3s"
      }
    }
  }
}
resource "yandex_alb_load_balancer" "web" {
  name       = "web-alb"
  network_id = yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.public.id
    }
  }

  listener {
    name = "http"

    endpoint {
      address {
        external_ipv4_address {}
      }

      ports = [80]
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.web.id
      }
    }
  }
}