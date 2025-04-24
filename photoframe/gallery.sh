#!/bin/bash

echo "🟢 Старт галереи"

OUTPUT_DIR="/home/orangepi/project/photoframe/output"
source ./config.cfg
echo "⏱️ Задержка между изображениями: $DELAY секунд"

while true; do
  for IMAGE in "$OUTPUT_DIR"/*.png; do
    if [ -f "$IMAGE" ]; then
      clear
      echo "🖼️ Показываем: $IMAGE"
      fbi -a "$IMAGE" > /dev/null 2>&1
      sleep "$DELAY"
    fi
  done
done
