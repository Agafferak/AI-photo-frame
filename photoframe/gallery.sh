#!/bin/bash

echo "🟢 Старт галереи"

# Прямо прописываем путь
OUTPUT_DIR="/home/orangepi/project/photoframe/output"
echo "📁 Папка для изображений: $OUTPUT_DIR"

# Прочитаем DELAY из config.cfg
source ./config.cfg
echo "⏱️ Задержка между изображениями: $DELAY секунд"

while true; do
  for IMAGE in "$OUTPUT_DIR"/*.png; do
    if [ -f "$IMAGE" ]; then
      echo "🖼️ Показываем: $IMAGE"
      fbi -T 1 -a "$IMAGE" > /dev/null 2>&1
      sleep "$DELAY"
    else
      echo "⚠️ Нет изображений в папке."
    fi
  done
done
