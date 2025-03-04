# Security Group для Bastion Host
resource "yandex_vpc_security_group" "bastion_sg" {
  name        = "bastion-sg"
  network_id  = data.yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]  # Открываем SSH для всех
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для приватных серверов (Web, Prometheus, Elasticsearch)
resource "yandex_vpc_security_group" "private_sg" {
  name        = "private-sg"
  network_id  = data.yandex_vpc_network.network.id

  # Разрешаем SSH доступ только от Bastion Host
  ingress {
    protocol       = "TCP"
    port           = 22
    security_group_id  = yandex_vpc_security_group.bastion_sg.id
  }

  # Разрешаем доступ HTTP для Web серверов 
  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ HTTPS для Web серверов
  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ для метрик от Node Exporter (порт 9100)
  ingress {
    protocol       = "TCP"
    port           = 9100
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ для метрик от Nginx Log Exporter (порт 9113)
  ingress {
    protocol       = "TCP"
    port           = 4040
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ для Filebeat (порт 5044)
  ingress {
    protocol       = "TCP"
    port           = 5044
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ для Prometheus (порт 9090)
  ingress {
    protocol       = "TCP"
    port           = 9090
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
 

 # Разрешаем доступ к Elasticsearch (порт 9200)
  ingress {
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group для публичных серверов (Grafana, Kibana)
resource "yandex_vpc_security_group" "public_sg" {
  name        = "public-sg"
  network_id  = data.yandex_vpc_network.network.id

  # Разрешаем доступ по SSH от Bastion Host
  ingress {
    protocol       = "TCP"
    port           = 22
    security_group_id  = yandex_vpc_security_group.bastion_sg.id
  }

  # Разрешаем доступ HTTP для Web серверов
  ingress {
    protocol       = "TCP"
    port           = 80  
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ HTTPS для Web серверов
  ingress {
    protocol       = "TCP"
    port           = 443 
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем доступ для Kibana (порт 5601)
  ingress {
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]  # Открываем Kibana для всех
  }

  # Разрешаем доступ для Grafana (порт 3000)
  ingress {
    protocol       = "TCP"
    port           = 3000
    v4_cidr_blocks = ["0.0.0.0/0"]  # Открываем Grafana для всех
  }

  # Разрешаем доступ к Prometheus (порт 9090)
  ingress {
    protocol       = "TCP"
    port           = 9090
    v4_cidr_blocks = ["0.0.0.0/0"]
#    security_group_id  = yandex_vpc_security_group.private_sg.id
  }

  # Разрешаем доступ к Elasticsearch (порт 9200)
  ingress {
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["0.0.0.0/0"]
#    security_group_id  = yandex_vpc_security_group.private_sg.id
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

