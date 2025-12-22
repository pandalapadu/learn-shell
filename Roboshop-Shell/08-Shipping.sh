#Maven is a Java Packaging software, Hence we are going to install maven, This indeed takes care of java installation.
cp 08.shipping.service /etc/systemd/system/shipping.service
dnf install maven -y
#Add application User
useradd roboshop
#Lets setup an app directory.
mkdir /app
#Download the application code to created app directory.
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
#Lets download the dependencies & build the application
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
#We need to load the schema. To load schema we need to install mysql client.
dnf install mysql -y
#Load Schema, Schema in database is the structure to it like what tables to be created and their necessary application layouts.
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/schema.sql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/app-user.sql
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/db/master-data.sql
systemctl restart shipping
