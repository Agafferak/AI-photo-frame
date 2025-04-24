#!/bin/bash

OUTPUT_DIR="/home/orangepi/project/photoframe/output"
MAX_IMAGES=1000

# Очистка старых изображений
clean_old_images() {
    IMAGE_COUNT=$(ls -1 "$OUTPUT_DIR" | wc -l)
    if [ "$IMAGE_COUNT" -gt "$MAX_IMAGES" ]; then
        echo "🧹 Превышено $MAX_IMAGES изображений, удаляем старые..."
        ls -1t "$OUTPUT_DIR" | tail -n +$((MAX_IMAGES + 1)) | xargs -I {} rm -f "$OUTPUT_DIR/{}"
    fi
}

# Сбор пользовательских параметров
read -p "Введите промпт: " PROMPT
read -p "Введите количество шагов проработки: " STEPS
read -p "Введите задержку между изображениями (в секундах): " DELAY

# Запуск галереи в фоне, если ещё не запущена
if ! pgrep -f "feh --fullscreen" > /dev/null; then
    echo "📸 Запуск галереи с изображениями..."
    feh --fullscreen --slideshow-delay "$DELAY" "$OUTPUT_DIR" &
    FEH_PID=$!
    echo "🟢 Галерея запущена с PID $FEH_PID"
else
    echo "ℹ️ Галерея уже запущена."
fi

# Бесконечная генерация изображений
while true; do
    TIMESTAMP=$(date +%s)
    OUTPUT_FILE="$OUTPUT_DIR/generated_$TIMESTAMP.png"

    echo "🎨 Генерация изображения: $OUTPUT_FILE"
    cd /home/orangepi/OnnxStream/src/build/
    ./sd --prompt "$PROMPT" --steps "$STEPS" --rpi --output "$OUTPUT_FILE"

    echo "✅ Сохранено: $OUTPUT_FILE"

    clean_old_images

    echo "⏳ Ожидание $DELAY секунд..."
    sleep "$DELAY"
done
