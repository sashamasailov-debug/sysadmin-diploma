resource "yandex_compute_instance" "bastion" {
  name     = "bastion"
  hostname = "bastion"

  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.bastion.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}
resource "yandex_compute_instance" "web1" {
  name     = "web-1"
  hostname = "web-1"

  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private_a.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.web.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}
resource "yandex_compute_instance" "web2" {
  name     = "web-2"
  hostname = "web-2"

  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private_d.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.web.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}
resource "yandex_compute_instance" "elasticsearch" {
  name     = "elasticsearch"
  hostname = "elasticsearch"

  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private_d.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.elasticsearch.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}
resource "yandex_compute_instance" "zabbix" {
  name     = "zabbix"
  hostname = "zabbix"

  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.zabbix.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}
resource "yandex_compute_instance" "kibana" {
  name     = "kibana"
  hostname = "kibana"

  platform_id = "standard-v3"
  zone        = "ru-central1-a"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = "fd83vkt13re8v8cdapql"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.zabbix.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/Sasha/Desktop/ДОМАШКА/ssh-key-1779172438900/ssh-key-1779172438900.pub")}"
  }
}