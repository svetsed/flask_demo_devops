#!/bin/bash

# How to use: sudo ./flask-docker-manager.sh [build|start|stop|restart|logs|check|clean]

USER_NAME="ENTER_YOUR_USERNAME"

APP_NAME="flask-container"                           # Имя контейнера
IMAGE_NAME="flask-system"                            # Имя образа
PORT=5001                                            # Порт хоста
APP_DIR="/home/$USER_NAME/mywebapp/"                 # Папка с проектом
DOCKERFILE_PATH="deployments/docker/Dockerfile"      # Путь до Dockerfile
APP_DIR="/home/$USER_NAME/mywebapp/app"              # Папка с кодом приложения

case "$1" in
  build)
    echo "Сборка Docker-образа..."
    cd "/home/$USER_NAME/mywebapp/"
    docker build -f $DOCKERFILE_PATH -t $IMAGE_NAME .
    ;;
  start)
    echo "Запуск контейнера..."
    docker run -d \
      --name $APP_NAME \
      -p $PORT:5000 \
      $IMAGE_NAME
    ;;
  stop)
    echo "Остановка контейнера..."
    docker stop $APP_NAME
    ;;
  restart)
    echo "Перезагрузка контейнера..."
    docker restart $APP_NAME
    ;;
  logs)
    echo "Просмотр логов..."
    docker logs -f $APP_NAME
    ;;
  clean)
    echo "Удаление контейнера и образа..."
    docker rm -f $APP_NAME 2>/dev/null
    docker rmi $IMAGE_NAME 2>/dev/null
    ;;
  check)
    echo "Проверка контейнеров..."
    docker ps -a
    echo ""
    echo "Проверка образов..."
    docker images
    ;;
  *)
    echo "  Использование: $0 {build|start|stop|restart|check|logs|clean}"
    echo ""
    echo "  build   - собрать Docker-образ"
    echo "  start   - запустить контейнер"
    echo "  stop    - остановить контейнер"
    echo "  restart - перезапустить контейнер"
    echo "  logs    - просмотр логов в реальном времени"
    echo "  check   - проверка контейнеров и образов"
    echo "  clean   - удалить контейнер и образ"
    exit 1
esac

exit 0
