#Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list.
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
cp 06.cart.service /etc/systemd/system/cart.service
#Install NodeJS
dnf install nodejs -y
#Add application User
useradd roboshop
#Lets setup an app directory.
mkdir /app
#Download the application code to created app directory.
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip
#Lets download the dependencies.
cd /app
npm install
#Load the service.
systemctl daemon-reload
#Start the service.
systemctl enable cart
systemctl start cart