# [Русская версия находится тут README.ru.md](./README.ru.md)
For convenience, the file autoinstall_ocat.sh has been added.

The original article can be found at the link https://cctv-m.ru/onioncat-%D0%B0%D0%BD%D0%BE%D0%BD%D0%B8%D0%BC%D0%BD%D0%BE%D0%B5-%D1%81%D0%BE%D0%B5%D0%B4%D0%B8%D0%BD%D0%B5%D0%BD%D0%B8%D0%B5-%D0%B8-ipv6-%D0%BB%D0%BE%D0%BA%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F-%D1%81%D0%B5%D1%82%D1%8C-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-tor

OnionCat: Anonymous Connection and IPv6 Local Network via Tor are typically required for connecting 2 or more devices behind NAT that do not have an external IP address among themselves. Yes, the speed will not be very high, but the connection between the devices will work.

In a world where anonymity and security online play a key role, there are many tools available to maintain your privacy and ensure a secure connection. One such tool is OnionCat. This software allows the creation of an anonymous IPv6 connection through the Tor network. In this article, we will look at how to install and configure OnionCat to ensure anonymity and security online.

Installing OnionCat

This was all assembled on Linux Debian 12.

Before starting, you will need the following utilities: make, automake, git, gcc, gawk, and clang, as well as the Tor client. You can install them with the following command:

```
  apt install make automake git gcc gawk clang tor
```
Next, clone the OnionCat repository from GitHub and move to the onioncat directory:
```
  git clone https://github.com/rahra/onioncat.git && cd onioncat
```
Now execute the configuration and installation of OnionCat with the following commands:
```
  ./configure && make && make install
```
Configuring Tor

After installing OnionCat, you need to configure Tor to create a hidden service. Open the Tor configuration file, which is usually located at /etc/tor/torrc, and add the following lines:

```
SocksPort 9050
HiddenServiceDir /var/lib/tor/onioncat/
HiddenServicePort 8060 127.0.0.1:8060
```

Obtaining an IPv6 Address

To obtain an IPv6 address for your OnionCat service, execute the following command:

```
cat /var/lib/tor/onioncat/hostname
```

You will receive a string similar to this:
```
2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion
```
Convert this address into an IPv6 format using the OnionCat utility:
```
ocat -i 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion
```
As a result of executing the command, you will receive an IPv6 address, for example:
```
fd87:d87e:eb43:b49a:7e15:4051:db80:a703
```
Configuring Addressing

Now, you need to create an onioncat.hosts file (if the file does not exist, create it) in the directory /usr/local/etc/tor/ (if the folder does not exist, simply create it) and add addressing for all the hosts you want to connect to your OnionCat service (including your own host). Example contents of the onioncat.hosts file:
```
fd87:d87e:eb43:b49a:7e15:4051:db80:a703 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion
fd87:d87e:eb43:5c26:e7b9:183b:c5cf:1303 zdinxa4upmv73ydwpwnymiwesyea4cpx2c5xz3nalqtopoiyhpc46eyd.onion
fd87:d87e:eb43:911d:811e:6edc:c24d:1c03 jsvntjdjxzsardcjeljigruhgdx4ozqotkidrrmqseoychto3tbe2had.onion
```
Launching OnionCat

Now you are ready to launch OnionCat. Use the following command, replacing the address with your own:
```
ocat -U 2ogtqsvcp7s7fizsoapte3tg2kruh6yehmfxx43xwsnh4fkakhnybjyd.onion
```
This will allow you to establish an anonymous IPv6 connection through the Tor network using OnionCat.

Conclusion

OnionCat provides a unique opportunity to create an anonymous IPv6 connection through the Tor network, ensuring a high level of security and anonymity. By following the instructions presented in this article, you can easily install and configure OnionCat for your own anonymous network. This tool will become a reliable ally in maintaining your privacy and security online.
