Оригинал статьи находится по ссылке https://cctv-m.ru/onioncat-%D0%B0%D0%BD%D0%BE%D0%BD%D0%B8%D0%BC%D0%BD%D0%BE%D0%B5-%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B8-ipv6-%D0%BB%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F-%D1%81%D0%B5%D1%82%D1%8C-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-tor
OnionCat: Анонимное соединение и IPv6 локальная сеть через Tor
В мире, где анонимность и безопасность в сети играют ключевую роль, существует множество инструментов, позволяющих сохранить вашу приватность и обеспечить безопасное соединение. Одним из таких инструментов является OnionCat. Это программное обеспечение позволяет создать анонимное IPv6-соединение через сеть Tor. В этой статье мы рассмотрим, как установить и настроить OnionCat для обеспечения анонимности и безопасности в сети.

Установка OnionCat

Всё собиралось на Linux debian 12

Прежде чем начать, вам понадобятся следующие утилиты: make, automake, git, gcc, gawk и clang, а также клиент Tor. Вы можете установить их с помощью следующей команды:

    apt install make automake git gcc gawk clang tor

Далее, склонируйте репозиторий OnionCat с GitHub и перейдите в директорию onioncat:

    git clone https://github.com/rahra/onioncat.git && cd onioncat

Теперь выполните конфигурацию и установку OnionCat с помощью следующих команд:

    ./configure && make && make install

Настройка Tor

После установки OnionCat, вам нужно настроить Tor для создания скрытого сервиса. Откройте файл конфигурации Tor, который обычно находится по пути /etc/tor/torrc, и добавьте следующие строки:

    SocksPort 9050
    HiddenServiceDir /var/lib/tor/onioncat/
    HiddenServicePort 8060 127.0.0.1:8060

Получение IPv6-адреса

Для того чтобы получить IPv6-адрес для вашего OnionCat сервиса, выполните следующую команду:

    cat /var/lib/tor/onioncat/hostname

Вы получите строку, похожую на данную:

    2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion

Преобразуйте этот адрес в IPv6-формат, используя утилиту OnionCat:

    ocat -i 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion

В результате выполнения команды вы получите IPv6-адрес, например:

    fd87:d87e:eb43:b49a:7e15:4051:db80:a703

Настройка адресации

Теперь вам нужно создать файл onioncat.hosts (если нет файла то создайте) в директории /usr/local/etc/tor/ (если папки нет, просто создайте её) и добавить в него адресацию для всех хостов, которые вы хотите связать с вашим OnionCat сервисом(нужно добавлять включая ваш хост). Пример содержимого файла onioncat.hosts:

    fd87:d87e:eb43:b49a:7e15:4051:db80:a703 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion
    fd87:d87e:eb43:5c26:e7b9:183b:c5cf:1303 zdinxa4upmv73ydwpwnymiwesyea4cpx2c5xz3nalqtopoiyhpc46eyd.onion
    fd87:d87e:eb43:911d:811e:6edc:c24d:1c03 jsvntjdjxzsardcjeljigruhgdx4ozqotkidrrmqseoychto3tbe2had.onion

Запуск OnionCat

Теперь вы готовы запустить OnionCat. Используйте следующую команду, заменив адрес на ваш собственный:

    ocat -U 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion


Это позволит вам установить анонимное IPv6-соединение через сеть Tor с помощью OnionCat.

Заключение

OnionCat предоставляет уникальную возможность создать анонимное IPv6-соединение через сеть Tor, обеспечивая высокий уровень безопасности и анонимности. Следуя инструкциям, представленным в этой статье, вы сможете легко установить и настроить OnionCat для вашей собственной анонимной сети. Этот инструмент станет надежным союзником в обеспечении вашей приватности и безопасности в сети.
