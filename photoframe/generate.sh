#!/bin/bash

CONFIG_FILE="./config.cfg"

echo "=== Фоторамка с нейросетью ==="
read -p "Введите промпт: " PROMPT
read -p "Введите количество шагов проработки (steps): " STEPS
read -p "Введите задержку между изображениями (в секундах): " DELAY

# Сохраняем параметры
echo "PROMPT=\"$PROMPT\"" > $CONFIG_FILE
echo "STEPS=$STEPS" >> $CONFIG_FILE
echo "DELAY=$DELAY" >> $CONFIG_FILE

# Проверка существования директории нейросети
if [ ! -d "/home/orangepi/OnnxStream/src/build" ]; then
    echo "❌ Ошибка: Папка с нейросетью не найдена. Проверь путь."
    exit 1
fi

# Путь для сохранения изображений
OUTPUT_DIR="/home/orangepi/project/photoframe/output"
mkdir -p "$OUTPUT_DIR"

# Генерация изображения
TIMESTAMP=$(date +%s)
OUTPUT_FILE="$OUTPUT_DIR/generated_$TIMESTAMP.png"

cd /home/orangepi/OnnxStream/src/build/ || exit 1

# Запуск нейросети с переданным количеством шагов
./sd --prompt "$PROMPT" --steps "$STEPS" --rpi --output "$OUTPUT_FILE"

echo "✅ Генерация завершена. Изображение сохранено в: $OUTPUT_FILE"

# Запуск галереи
bash /home/orangepi/project/photoframe/gallery.sh
