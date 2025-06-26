#!/bin/bash

if [ -z "$1" ]; then
  echo "Ошибка: укажите путь к папке."
  exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Ошибка: '$TARGET_DIR' не является директорией."
  exit 1
fi

for FILE in "$TARGET_DIR"/*; do
    if [ -d "$FILE" ]; then
    continue
  fi

  BASENAME=$(basename "$FILE")
  EXT="${BASENAME##*.}"
    if [ "$BASENAME" = "$EXT" ]; then
    EXT="no_extension"
  fi

  DEST_DIR="$TARGET_DIR/$EXT"

    mkdir -p "$DEST_DIR"

    mv "$FILE" "$DEST_DIR/"
done

echo "Сортировка завершена."
