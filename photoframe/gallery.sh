#!/bin/bash

# Загружаем параметры
source ./config.cfg

# Жёстко задаём путь к папке с изображениями
OUTPUT_DIR="/home/orangepi/project/photoframe/output"

# Отображение изображений из OUTPUT_DIR
while true; do
  # Показать все PNG по порядку
  for IMAGE in "$OUTPUT_DIR"/*.png; do
    # Проверка, существует ли файл
    if [ -f "$IMAGE" ]; then
      fbi -T 1 -a "$IMAGE" > /dev/null 2>&1
      sleep "$DELAY"
    fi
  done
done
