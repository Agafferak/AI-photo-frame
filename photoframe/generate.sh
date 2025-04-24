#!/bin/bash

# Параметры генерации
OUTPUT_DIR="/home/orangepi/project/photoframe/output"
DELAY=5  # Задержка между изображениями (например, 5 секунд)

# Максимальное количество изображений в папке
MAX_IMAGES=1000

# Проверка количества изображений в папке и удаление старых, если нужно
clean_old_images() {
    IMAGE_COUNT=$(ls -1 "$OUTPUT_DIR" | wc -l)
    
    if [ "$IMAGE_COUNT" -gt "$MAX_IMAGES" ]; then
        echo "Превышен лимит изображений ($MAX_IMAGES). Удаление старых..."
        # Удаляем самые старые изображения (по времени создания)
        ls -1t "$OUTPUT_DIR" | tail -n +$((MAX_IMAGES + 1)) | xargs -I {} rm -f "$OUTPUT_DIR/{}"
        echo "Старые изображения удалены."
    fi
}

# Главный цикл генерации изображений
while true; do
    echo "Введите промпт для генерации изображения:"
    read -p "Промпт: " PROMPT
    read -p "Шаги проработки (например, 20): " STEPS

    # Генерация изображения
    OUTPUT_FILE="$OUTPUT_DIR/generated_$(date +%s).png"
    echo "Генерация изображения... Путь сохранения: $OUTPUT_FILE"
    
    # Запуск нейросети для генерации изображения
    cd /home/orangepi/OnnxStream/src/build/
    ./sd --prompt "$PROMPT" --steps "$STEPS" --rpi --output "$OUTPUT_FILE"

    # Очищаем старые изображения, если их слишком много
    clean_old_images

    # Запуск галереи с обновлённым изображением
    echo "Открытие галереи..."
    bash /home/orangepi/project/photoframe/gallery.sh

    # Пауза перед следующим изображением
    echo "Генерация завершена, следующее изображение будет через $DELAY секунд..."
    sleep "$DELAY"
done
