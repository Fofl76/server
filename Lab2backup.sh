#!/bin/bash

if [ $# -lt 2 ]; then
  echo "Использование: $0 <директория_для_бэкапа> <директория_для_хранения> [дата в формате YYYY-MM-DD]"
  exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"
DATE_STR="${3:-$(date +%F)}"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Ошибка: директория для бэкапа '$SOURCE_DIR' не существует."
  exit 2
fi

mkdir -p "$BACKUP_DIR"

BASENAME=$(basename "$SOURCE_DIR")
ARCHIVE_NAME="${BASENAME}_${DATE_STR}.tar.gz"
ARCHIVE_PATH="${BACKUP_DIR}/${ARCHIVE_NAME}"

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$SOURCE_DIR")" "$BASENAME"
if [ $? -eq 0 ]; then
  echo "Бэкап успешно создан: $ARCHIVE_PATH"
else
  echo "Ошибка при создании архива."
  exit 3
fi

echo "Удаление архивов старше 7 дней:"
find "$BACKUP_DIR" -name "${BASENAME}_*.tar.gz" -type f -mtime +7 -delete
