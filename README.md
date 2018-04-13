# Docker SOCKS5 Proxy

Данный репозиторий позволит с минимальными затратами запустить свой собственный socks5 proxy-сервер.

## Quickstart

Ниже приведена инструкция по подъему SOCKS5 прокси. Единственное требование - наличие [белого](https://help.keenetic.net/hc/ru/articles/213965789-В-чем-отличие-белого-и-серого-IP-адреса-) IP.

1. Установите Docker engine.
   
   Выберите инструкцию для вашей ОС. Тестирование всей системы проводилось только для Ubuntu, но для других ОС все также должно работать с некоторыми модификациями приведенных ниже команд.
 
   1. [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)
   2. [Mac](https://docs.docker.com/docker-for-mac/install/)
   3. [Windows](https://docs.docker.com/docker-for-windows/install/)
   
2. Склонируйте данный репозиторий

   ```bash
   git clone https://github.com/elejke/docker-socks5.git
   cd docker-socks5
   ```
   
3. Соберите Docker-образ

   ```bash
   sudo docker build -t socks5 .
   ```
   
   Если вы хотите использовать логин и пароль для своего сервера, то исправьте соответствующую строчку в [Dockerfile](Dockerfile#L4) на желаемую пару логин/пароль.
   
4. Запустите Docker-образ:

   ```bash
   sudo docker run -d -p 80:1080 socks5
   ```
   
   В данном случае прокси-сервер будет работать на порте 80. Вы можете изменить его на произвольный изменив соответствующее число при запуске Docker-контейнера. Обратите внимание, что выбранный порт должен быть открыт для доступа извне.
   
   Если вы хотите использовать логин/пароль для своего прокси, то надо также добавить файл конфигурации в Docker-контейнер, что делается добавлением опции при запуске:
   
   ```bash
   sudo docker run -d -p 80:1080 -v ${PWD}/sockd.conf:/etc/sockd.conf socks5
   ```
   
   При этом будут использованы логин/пароль указанные на шаге 3.
   
5. Ваш прокси-сервер готов!

   Используйте ваш IP-адрес, указанный на шаге 4 порт и логин/пароль (если заданы) в любом приложении!
   
   Для Telegram соответствующие настройки лежат в: 
   
   1. **iOS**: Settings - Data and Storage - Use Proxy
   2. **Desktop**: Settings - Privacy and Security - Use Proxy
   
## Беслатный сервер на Amazon [AWS](https://aws.amazon.com)

1. Рагистрация AWS аккаунта с возможностью поднятия бесплатных серверов в течении 12 месяцев:
   
   1. Создайте аккаунт на https://aws.amazon.com/free/ выбрав тип аккаунт Personal. При использовании бесплатных серверов деньги с привязанной карты не будут расходоваться за исключением 1$, который будет снят при регистрации.
   2. Войдите в созданный акканут с помощью: https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fconsole.aws.amazon.com%2Fconsole%2Fhome%3Fstate%3DhashArgs%2523%26isauthcode%3Dtrue&client_id=arn%3Aaws%3Aiam%3A%3A015428540659%3Auser%2Fhomepage&forceMobileApp=0, нажав в нижней части Sign-in using root account credentials и введя свой email, указанный при регистрации.
   3. Окончание регистрации и подтверждение возможности выделения ресурсов может занять до 24 часов. Проверить, закончилась она или нет можно в консоли: зайдите во вкладку Services и нажмите EC2

2. Для запуска бесплатного сервера на AWS EC2 зайдите во вкладку Services > EC2 и нажмите Launch Instance, в левой части нажмите галочку возле надписи Free tier only и выберите в списке образ Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-43a15f3e
    
   1. Выберите t2.micro
   2. В верхней части экрана кликните Configure Security Group, нажмите Add Rule и в выпадающем списке выберите HTTP (ваш прокси сервер будет уже сконфигурирован для использования 80) 
   3. Нажмите Review and Launch > Launch
      
     1. В появившемся окне нажмите Create a new key pair,назовите её socks5 и нажмите Download Key Pair и Launch Instance.
     2.  Поздравляю! Вы запустили сервер.

3. Зайдите во вкладку Instances в левой части консоли EC2 и выберите запущенный сервер, нажмите клавишу Connect и следуйте указаниям (измените права ключа и подключитесь из консоли по ssh)
