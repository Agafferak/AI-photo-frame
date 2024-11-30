#!/bin/bash

# Папка с изображениями
IMAGE_DIR="/usr/Project/Images"

# Запуск галереи в полном экране с периодом смены изображения в 15 секунд
feh --fullscreen --slideshow-delay 15 "$IMAGE_DIR"
