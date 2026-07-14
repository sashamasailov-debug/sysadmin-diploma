resource "yandex_vpc_security_group" "bastion" {
  name       = "bastion-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "web" {
  name       = "web-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol          = "ANY"
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP from ALB"
    port           = 80
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "SSH from Bastion"
    port           = 22
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix Agent"
    port           = 10050
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "monitoring" {
  name       = "monitoring-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Zabbix Server"
    port           = 10051
    v4_cidr_blocks = ["10.128.0.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Kibana"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Elasticsearch"
    port           = 9200
    v4_cidr_blocks = ["10.130.0.0/24"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "elasticsearch" {
  name       = "elasticsearch-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "zabbix" {
  name       = "zabbix-sg"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    port           = 10051
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    protocol       = "TCP"
    port           = 10050
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    protocol       = "TCP"
    port           = 5601
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}