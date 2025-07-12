FROM ubuntu:22.04

# 1. Обновляем систему и ставим Python + системный Flask
RUN apt-get update && \
    apt-get install -y python3 python3-flask && \
    rm -rf /var/lib/apt/lists/*

# 2. Создаём рабочую папку
WORKDIR /app

# 3. Копируем код из папки app
COPY app/app.py .

# 4. Открываем порт
EXPOSE 5000

# 5. Запускаем приложение
CMD ["python3", "app.py"]