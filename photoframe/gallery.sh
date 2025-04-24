#!/bin/bash

echo "🖼️ Запуск галереи через feh..."

OUTPUT_DIR="/home/orangepi/project/photoframe/output"
source ./config.cfg

echo "⏱️ Задержка между изображениями: $DELAY секунд"

feh --fullscreen --slideshow-delay "$DELAY" "$OUTPUT_DIR"
