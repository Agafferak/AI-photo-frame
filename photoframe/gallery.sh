#!/bin/bash

source ./config.cfg

echo "=== Галерея изображений ==="
echo "Промпт: $PROMPT"
echo "Задержка между изображениями: $DELAY секунд"
echo "Изображения из: $IMAGE_DIR"
echo "Сгенерированные изображения из: /project/output/"
echo "Нажмите Ctrl+C для выхода."

while true; do
    for img in "$IMAGE_DIR"/*.png /project/output/*.png; do
        if [[ -f "$img" ]]; then
            fbi -T 1 -d /dev/fb0 --noverbose "$img" 2>/dev/null
            sleep "$DELAY"
        fi
    done
done
