output "bastion_public_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
  description = "Публичный IP адрес Bastion Host"
}

output "vm1_private_ip" {
  value = yandex_compute_instance.vm1.network_interface.0.ip_address
  description = "Приватный IP адрес VM1"
}

output "vm2_private_ip" {
  value = yandex_compute_instance.vm2.network_interface.0.ip_address
  description = "Приватный IP адрес VM2"
}

output "prometheus_private_ip" {
  value = yandex_compute_instance.prometheus_vm.network_interface.0.ip_address
  description = "Приватный IP адрес VM с Prometheus"
}

output "grafana_public_ip" {
  value = yandex_compute_instance.grafana_vm.network_interface.0.nat_ip_address
  description = "Публичный IP адрес VM с Grafana"
}

output "elasticsearch_private_ip" {
  value = yandex_compute_instance.elasticsearch_vm.network_interface.0.ip_address
  description = "Приватный IP адрес VM с Elasticsearch"
}

output "kibana_public_ip" {
  value = yandex_compute_instance.kibana_vm.network_interface.0.nat_ip_address
  description = "Публичный IP адрес VM с Kibana"
}

output "alb_public_ip" {
  value = yandex_alb_load_balancer.web_load_balancer.listener[0].endpoint[0].address
  description = "Публичный IP адрес балансировщика нагрузки (ALB)"
}
