#!/bin/bash

# Загружаем параметры
source ./config.cfg

# Показ изображений из указанной директории
for IMAGE in "$OUTPUT_DIR"/*.png; do
    # Отображаем изображение с помощью fbi
    fbi -T 1 -a "$IMAGE" > /dev/null 2>&1
    sleep "$DELAY"
done
