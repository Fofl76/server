#!/bin/bash
if [ $# -lt 3 ]; then
  echo "Использование: $0 <директория> <расширение> <топ-N> [файл_стоп_слов]"
  exit 1
fi

DIR="$1"
EXT="$2"
TOP_N="$3"
STOP_WORDS_FILE="$4"

declare -A freq
declare -A stopwords

if [[ -n "$STOP_WORDS_FILE" && -f "$STOP_WORDS_FILE" ]]; then
  while read -r word; do
    word=$(echo "$word" | tr -d '\r' | tr '[:upper:]' '[:lower:]')
    stopwords["$word"]=1
  done < "$STOP_WORDS_FILE"
fi

files=$(find "$DIR" -type f -name "*.${EXT}")
if [ -z "$files" ]; then
  echo "Нет файлов с расширением .$EXT в директории $DIR"
  exit 1
fi

for file in $files; do
  while read -r word; do
    word=$(echo "$word" | tr -d '\r' | tr '[:upper:]' '[:lower:]')

    if [[ -n "${stopwords[$word]}" ]]; then
      continue
    fi

    ((freq["$word"]++))
  done < <(grep -oEh '\w+' "$file" 2>/dev/null)
done

if [ ${#freq[@]} -eq 0 ]; then
  echo "Нет данных для анализа"
  exit 1
fi

for word in "${!freq[@]}"; do
  echo "$word: ${freq[$word]}"
done | sort -t ':' -k2 -nr | head -n "$TOP_N"
