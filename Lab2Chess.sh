#!/bin/bash

WHITE_BG="\e[47m"
BLACK_BG="\e[40m"
RESET="\e[0m"


read -p "Введите размер доски: " size

if ! [[ "$size" =~ ^[0-9]+$ ]] || [ "$size" -le 0 ]; then
  echo "Пожалуйста, введите положительное целое число."
  exit 1
fi

echo -e "\nШахматная доска ${size}x${size}:\n"

for ((row=0; row<size; row++)); do
  for ((col=0; col<size; col++)); do
    if (( (row + col) % 2 == 0 )); then
      echo -ne "${WHITE_BG}  ${RESET}"
    else
      echo -ne "${BLACK_BG}  ${RESET}"
    fi
  done
  echo
done
