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

# Проверка существования директории нейросети
if [ ! -d "/home/orangepi/OnnxStream/src/build" ]; then
    echo "❌ Ошибка: Папка с нейросетью не найдена. Проверь путь."
    exit 1
fi

# Генерация изображения
TIMESTAMP=$(date +%s)
OUTPUT_FILE="/project/output/generated_$TIMESTAMP.png"

mkdir -p /project/output/

cd /home/orangepi/OnnxStream/src/build/ || exit 1

./sd --prompt "$PROMPT" --steps 3 --rpi --output "$OUTPUT_FILE"

echo "✅ Генерация завершена. Изображение сохранено в: $OUTPUT_FILE"

# Запуск галереи из текущего каталога скрипта
bash "$(dirname "$0")/gallery.sh"
