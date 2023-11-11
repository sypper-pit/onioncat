#!/usr/bin/bash

# Переменные с настройками
socks_port="SocksPort 9050"
hidden_service_dir="HiddenServiceDir /var/lib/tor/onioncat/"
hidden_service_port="HiddenServicePort 8060 127.0.0.1:8060"

# Путь к файлу конфигурации torrc
torrc_file="/etc/tor/torrc"

# Путь к файлу с доменным именем
hostname_file="/var/lib/tor/onioncat/hostname"

# Путь к файлу onioncat.hosts
onioncat_hosts_file="/usr/local/etc/tor/onioncat.hosts"

# Путь к каталогу onioncat
onioncat_dir="onioncat"

# Проверка наличия записей в файлах и каталогах
if [ -e "$torrc_file" ]; then
    echo "Файл конфигурации $torrc_file уже существует."
    exit 1
fi

if [ -e "$onioncat_hosts_file" ]; then
    echo "Файл $onioncat_hosts_file уже существует."
    exit 1
fi

if [ -d "$onioncat_dir" ]; then
    echo "Каталог $onioncat_dir уже существует."
    exit 1
fi

# Устанавливаем необходимые пакеты
apt update && apt upgrade -y
apt install make automake git gcc gawk clang tor -y

# Клонируем репозиторий OnionCat
git clone https://github.com/rahra/onioncat.git
cd onioncat || exit 1

# Выполняем сборку
./autogen.sh
./configure
make
make install

# Проверяем успешность выполнения сборки
if [ $? -ne 0 ]; then
    echo "Ошибка при клонировании или сборке OnionCat."
    exit 1
fi

# Добавляем строки в файл конфигурации
echo "$socks_port" | tee -a "$torrc_file"
echo "$hidden_service_dir" | tee -a "$torrc_file"
echo "$hidden_service_port" | tee -a "$torrc_file"
echo "Настройки добавлены в $torrc_file"

# Перезапускаем tor
systemctl restart tor

# Создаем директорию /usr/local/etc/tor/
mkdir -p /usr/local/etc/tor/

# Ожидаем появление файла с доменным именем
while [ ! -e "$hostname_file" ]; do
    sleep 5
done

# Выводим доменное имя
onion_domain=$(cat "$hostname_file")
echo "Доменное имя: $onion_domain"

# Создаем директорию и файл для onioncat.hosts
mkdir -p /usr/local/etc/tor/
touch "$onioncat_hosts_file"

# Выполняем команду onioncat
ocat_command="ocat -i $onion_domain"
ocat_response=$($ocat_command)

# Проверяем успешность выполнения команды
if [ $? -eq 0 ]; then
    # Выводим ответ от onioncat
    echo "Ответ onioncat: $ocat_response"

    # Получаем IPv6-адрес из ответа
    ipv6_address=$(echo "$ocat_response" | awk '{print $1}')

    # Выводим IPv6-адрес
    echo "IPv6-адрес: $ipv6_address"

    # Записываем в файл onioncat.hosts
    echo "$ipv6_address $onion_domain" | tee -a "$onioncat_hosts_file"
    echo "Запись добавлена в $onioncat_hosts_file"
else
    echo "Ошибка выполнения команды onioncat."
fi
