# Дипломная работа по профессии «Системный администратор»

## Выполнение дипломной работы

### 1. Сайт

Выполнено:

- создан bastion-хост для SSH-доступа к серверам внутренней сети;
- созданы два веб-сервера `web-1` и `web-2` в разных зонах доступности;
- настроен NAT Gateway и таблица маршрутизации `private-route` для приватных подсетей;
- установлен и запущен Nginx на обоих веб-серверах;
- создан и настроен L7 Application Load Balancer;
- настроены Target Group, Backend Group и HTTP Router;
- выполнена проверка работы балансировщика.

### Проверка

```bash
curl http://158.160.201.220
```

Балансировщик успешно распределяет запросы между серверами `web-1` и `web-2`.

### Скриншоты

#### Виртуальные машины

![ВМ](screenshots/01-vms.png)

#### NAT Gateway

![NAT](screenshots/02-nat-route.png)

#### Балансировщик

![LB](screenshots/03-load-balancer.png)

#### WEB-1

![WEB1](screenshots/04-web1-nginx.png)

#### WEB-2

![WEB2](screenshots/05-web2-nginx.png)

#### Проверка curl

![curl](screenshots/06-curl-balancer.png)

#### Проверка балансировки

![balance](screenshots/07-load-balancing.png)

## 2. Мониторинг

В рамках выполнения дипломной работы развернут сервер мониторинга Zabbix 7.0.

На серверах `web-1` и `web-2` установлен и настроен `Zabbix Agent 2`. После подключения агенты успешно зарегистрированы на сервере Zabbix и находятся в состоянии **Available (ZBX)**.

Создан Dashboard для мониторинга основных показателей серверов.

На панели мониторинга отображаются:

- загрузка процессора (CPU);
- использование оперативной памяти (RAM);
- использование дискового пространства;
- входящий сетевой трафик;
- исходящий сетевой трафик.

### Скриншоты

#### Подключенные хосты

![Zabbix Hosts](screenshots/08-zabbix-hosts.png)

#### Dashboard

![Zabbix Dashboard](screenshots/09-zabbix-dashboard.png)

## 3. Сбор логов

Выполнено:

- развернут Elasticsearch 8.18 в Docker;
- развернута Kibana 8.18 в Docker;
- на web-1 и web-2 установлен Filebeat;
- настроена отправка access.log и error.log Nginx в Elasticsearch;
- в Kibana успешно отображаются логи обоих веб-серверов.

### Скриншоты

#### Elasticsearch

![Elasticsearch](screenshots/09-elasticsearch.png)

#### Kibana

![Kibana](screenshots/10-kibana.png)

#### Логи в Discover

![Discover](screenshots/11-kibana-discover.png)

## 4. Резервное копирование

Выполнено:

- создано расписание ежедневного резервного копирования;
- в расписание добавлены все виртуальные машины;
- хранится 7 последних снимков.

### Скриншоты

#### Расписание резервного копирования

![Backup](screenshots/13-backup-schedule.png)