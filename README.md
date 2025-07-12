# Flask DevOps Demo Application

Простое Flask приложение с несколькими вариантами развертывания:
1. Локальный запуск
2. Развертывание через Ansible + systemd
3. Docker контейнеризация

## Особенности
-  Супер простое Flask приложение
-  Автоматическое развертывание с Ansible
-  Запуск как systemd сервиса
-  Docker контейнеризация
-  Скрипт для удобного управления контейнером

## Структура проекта
```
/home/username/mywebapp/
├── app/
│   └── app.py                # Основной файл Flask приложения 
├── deployments/
│   ├── ansible/
│   │   ├── playbook.yml      # Ansible плейбук
|   |   ├── inventory.ini     # Чем будет управлять Ansible (тут изменить данные)
│   │   └── templates/
│   │       └── mywebapp.service.j2  # Шаблон systemd
│   └── docker/
│       ├── Dockerfile        # Docker конфигурация
│       └── flask-docker-manager.sh  # Скрипт управления (тут изменить данные)
├── README.md                # Документация

```

## Ansible + systemd
1. Замените данные в файле `inventori.ini`
2. Создайте файл для службы
```
sudo touch /etc/systemd/system/mywebapp.service
```
3. Перейдите в папку `ansible` и выполните:
```
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass
```
*Обратите внимание! Потребуется ввести пароль пользователя.*

4. Проверьте статус сервиса:
```
sudo systemctl status mywebapp
```
Должен быть активен и гореть зелёным.

Другие команды для сервиса:
```
sudo systemctl daemon-reload  # перезапуск службы (необходимо при изменении файлов службы)
sudo systemctl start mywebapp # запуск сервиса
sudo systemctl stop mywebapp  # остановка
```
5. Откройте приложение
```
http://ваш_ip_тут:5000/
```

## Docker
1. Перейдите в папку `docker` и откройте скрипт в редакторе, например, nano и измените переменную `user_name` на свое имя пользователя
```
sudo nano flask-docker-manager.sh
```
*Не забудьте сохранить и выйти! В nano это Ctrl + O -> Enter -> Ctrl + X*
2. Дайте права на запуск
```
sudo chmod +x flask-docker-manager.sh
```
3. Запускайте скрипт от sudo
```
sudo ./flask-docker-manager.sh [команда]
```
Доступные команды:
./flask-docker-manager.sh [build|start|stop|restart|logs|check|clean]

4. Для запуска  build -> затем start
```
sudo ./flask-docker-manager.sh build
sudo ./flask-docker-manager.sh start
```
*Будет здесь: http://127.0.0.1:5001/*
5. После работы остановите контейнер и удалите его
```
sudo ./flask-docker-manager.sh stop
sudo ./flask-docker-manager.sh clean
```

