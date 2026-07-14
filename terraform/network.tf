resource "yandex_vpc_network" "network" {
  name = "netology-vpc"
}

resource "yandex_vpc_gateway" "nat" {
  name = "nat-gateway"

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private_route" {
  name       = "private-route"
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}

resource "yandex_vpc_subnet" "private_a" {
  name           = "private-subnet-a"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.129.0.0/24"]

  route_table_id = yandex_vpc_route_table.private_route.id
}

resource "yandex_vpc_subnet" "private_d" {
  name           = "private-subnet-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["10.130.0.0/24"]

  route_table_id = yandex_vpc_route_table.private_route.id
}