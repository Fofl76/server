#!/bin/bash

output_info() {
    echo "==========================================="
    echo "$1"
    echo "==========================================="
    shift
    "$@"
    echo
}

show_menu() {
    clear
    echo "Системное меню:"
    echo "1. Текущий рабочий каталог"
    echo "2. Текущие запущенные процессы"
    echo "3. Домашний каталог"
    echo "4. Название и версия ОС"
    echo "5. Доступные оболочки"
    echo "6. Текущие пользователи"
    echo "7. Количество пользователей"
    echo "8. Информация о жестких дисках"
    echo "9. Информация о процессоре"
    echo "10. Информация о памяти"
    echo "11. Информация о файловой системе"
    echo "12. Информация об установленных пакетах ПО"
    echo "13. Вывести всю информацию"
    echo "14. Выйти"
    echo -n "Выберите опцию: "
}

output_all() {
    output_info "Текущий рабочий каталог" pwd
    output_info "Текущие запущенные процессы" ps u
    output_info "Домашний каталог" echo "$HOME"
    output_info "Название и версия ОС" cat /etc/os-release
    output_info "Доступные оболочки" cat /etc/shells
    output_info "Текущие пользователи" who
    output_info "Количество пользователей $(who | wc -l)"
    output_info "Информация о жестких дисках" lsblk
    output_info "Информация о процессоре" lscpu
    output_info "Информация о памяти" free -h
    output_info "Информация о файловой системе" df -h
    output_info "Информация об установленных пакетах ПО" dpkg -l
}

if [[ "$1" == "--tofile" && -n "$2" ]]; then
    output_all > "$2"
    echo "Вывод записан в файл $2"
    exit 0
fi

while true; do
    show_menu
    read -r option
    case $option in
        1) output_info "Текущий рабочий каталог" pwd ;;
        2) output_info "Текущие запущенные процессы" ps u ;;
        3) output_info "Домашний каталог" echo "$HOME" ;;
        4) output_info "Название и версия ОС" cat /etc/os-release ;;
        5) output_info "Доступные оболочки" cat /etc/shells ;;
        6) output_info "Текущие пользователи" who ;;
        7) output_info "Количество пользователей" echo $(who | wc -l);;
        8) output_info "Информация о жестких дисках" lsblk ;;
        9) output_info "Информация о процессоре" lscpu ;;
        10) output_info "Информация о памяти" free -h ;;
        11) output_info "Информация о файловой системе" df -h ;;
        12) output_info "Информация об установленных пакетах ПО" dpkg -l ;;
        13) output_all ;;
        14) exit 0 ;;
        *) echo "Некорректный ввод, попробуйте снова." ;;
    esac
    echo "Для продолжения нажмите Enter..."
    read -r
done

