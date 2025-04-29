#!/bin/bash

# Function to create a folder if it doesn't exist
create_folder() {
    local folder_path="$1"

    if [ -z "$folder_path" ]; then
        echo "Error: No folder path provided."
        return 1
    fi

    if [ ! -d "$folder_path" ]; then
        mkdir -p "$folder_path"
        if [ $? -eq 0 ]; then
            echo "Folder created: $folder_path"
        else
            echo "Error: Failed to create folder: $folder_path"
            return 1
        fi
    else
        echo "Folder already exists: $folder_path"
    fi

    return 0
}

# Папка с изображениями
IMAGE_DIR="/usr/Project/Images"

create_folder $IMAGE_DIR
# Запуск галереи в полном экране с периодом смены изображения в 15 секунд
feh --fullscreen --slideshow-delay 15 "$IMAGE_DIR"
