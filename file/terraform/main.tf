terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.129.0"
    }
  }
  required_version = ">= 1.8.4"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

data "yandex_vpc_network" "network" {
  name  = "region-b"
}

# Создание сети
#resource "yandex_vpc_network" "network" {
#  name        = "region-b"
#  folder_id   = var.folder_id
#}

# Создание публичной подсети (subnet A)
resource "yandex_vpc_subnet" "public_subnet_a" {
  name           = "public-subnet-a"
  zone           = "ru-central1-a"
  network_id     = data.yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Создание приватной подсети (subnet A)
resource "yandex_vpc_subnet" "private_subnet_a" {
  name           = "private-subnet-a"
  zone           = "ru-central1-a"
  network_id     = data.yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Создание приватной подсети (subnet B)
resource "yandex_vpc_subnet" "private_subnet_b" {
  name           = "private-subnet-b"
  zone           = "ru-central1-b"
  network_id     = data.yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Создание NAT Gateway (для выхода в интернет из приватных подсетей)
resource "yandex_vpc_gateway" "nat_gateway" {
  name        = "nat-gateway"
  shared_egress_gateway {}
}

# Создание таблицы маршрутов для публичной подсети
resource "yandex_vpc_route_table" "rt" {
  name       = "public-route-table"
  network_id = data.yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}


