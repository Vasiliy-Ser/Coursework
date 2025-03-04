# Курсовая работа на профессии "`DevOps-инженер с нуля`" - `Падеев Василий`


   
### Задание 1. Кеширование

![tasks](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/Tasks.md)



Решение:

1. Запускаем terraform и устанавливаем инфраструктуру для сайта

![terraform](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/terraform.png)


2. Полученные  ip адреса необходимо внести в файлы:

- .ssh/config  
- ansible/inventory.ini   
- ansible/tasks/prometheus.yml  
- ansible/tasks/kibana.yml  
- ansible/deploy_packages.yml  


3. Запускаем ansible/deploy_packages.yml для копирования filebeat, prometheus, kibana, grafana, elasticsearch на удаленные сервера. Подготовленные файлы должны размещаться в корне домашней директории

```
ansible-playbook  deploy_packages.yml -i inventory.ini

```

![deploy_packages1](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/deploy-packages1.png)

![deploy_packages2](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/deploy-packages2.png)

![tasks]


4. Запускаем установку nginx на веб сервера ansible/nginx.yml и stub-status.yml

```

ansible-playbook  nginx.yml -i inventory.ini  
ansible-playbook  stab_status.yml -i inventory.ini

```

![nginx](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/nginx1.png)

![nginx](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/nginx2.png)


5. Запускаем установку сервисов ilebeat, prometheus, kibana, grafana, elasticsearch на сервера

```
ansible-playbook  site.yml -i inventory.ini  

```

![site](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/site.png)


6. На сервере elasticsearch необходимо произвести настройку:

6.1  В конфигурационном файле /etc/elasticsearch/elasticsearch.yml необходимо:  
- включение порта 9200
- network.host: указать адрес сетевого интерфейса на котором будет прослушка  
- xpack.security.http.ssl.enabled:false - мы будем использовать протокол http 

6.2 Cгенерировать пароли для elastic, kibana_system:

 ```
sudo systemctl status elasticsearch
sudo systemctl stop elasticsearch
sudo systemctl start elasticsearch
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system
sudo systemctl status elasticsearch

```

![elasticsearch](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/elasticsearch.png)

 
7. Полученные пароль необходимо указать в файле ansible/filebeat.yml.j2. На сервере kibana в конфигурационном файле /etc/kibana/kibana.yml необходимо изменить имя пользователя на kibana_system и пароль


8. Запускаем установку filebeat

```
ansible-playbook  filebeat.yml -i inventory.ini

```

![filebeat](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/filebeat.png)


9. Проверяем работу сервисов на серверах,  подключившись по SSH

```
sudo systemctl status <сервис>

```

Если где то не работает, запускаем 

```
sudo systemctl start  <сервис>

```


10. На серверах Grafana и Kibana настраиваем dashboard


![Grafana](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/Dashboards.png)

![Kibana1](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/kibana1.png)

![Kibana2](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/kibana2.png)


11. Проверяем работу  расписания snapshots в Yandex Cloud

![snapshots](https://github.com/Vasiliy-Ser/Coursework/blob/4621f36da4b1807d07ba60930de9f7e5794029ce/png/snapshot.png)



