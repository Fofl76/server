#!/bin/bash

if [ -z "$1" ]; then
    echo "Использование: $0 /путь/к/директории"
    exit 1
fi

dir="$1"

human_readable() {
    local size=$1
    local units=("B" "K" "M" "G" "T")
    local i=0

    while (( size >= 1024 && i < ${#units[@]} - 1 )); do
        size=$((size / 1024))
        ((i++))
    done

    printf "%s%s\n" "$size" "${units[$i]}"
}


calculate_dir_size() {
    local path="$1"
    local total_size=0

    while IFS=read -r -d '' file; do
        size=$(stat --format="%s" "$file")
        total_size=$((total_size + size))
    done < <(find "$path" -type f -print0)

    echo "$total_size"
}


find "$dir" -type d | while read -r subdir; do
    size_bytes=$(calculate_dir_size "$subdir")
    size_human=$(human_readable "$size_bytes")
    echo "$subdir: $size_human"
done
