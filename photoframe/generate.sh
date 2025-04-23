#!/bin/bash

CONFIG_FILE="./config.cfg"

echo "=== Фоторамка с нейросетью ==="
read -p "Введите промпт: " PROMPT
read -p "Введите задержку между изображениями (в секундах): " DELAY
read -p "Укажите путь к папке с изображениями: " IMAGE_DIR

# Сохраняем параметры
echo "PROMPT=\"$PROMPT\"" > $CONFIG_FILE
echo "DELAY=$DELAY" >> $CONFIG_FILE
echo "IMAGE_DIR=\"$IMAGE_DIR\"" >> $CONFIG_FILE

# Генерация изображения
TIMESTAMP=$(date +%s)
OUTPUT_FILE="/project/output/generated_$TIMESTAMP.png"

cd OnnxStream/src/build/ || exit 1

./sd --prompt "$PROMPT" --steps 3 --rpi --output "$OUTPUT_FILE"

echo "Генерация завершена. Изображение сохранено в: $OUTPUT_FILE"

# Запуск галереи
bash gallery.sh
