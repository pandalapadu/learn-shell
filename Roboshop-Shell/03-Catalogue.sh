#mongo client installed we have to setup MongoDB repo and install mongo.repo
cp 03.mongodb-client-ForCatalogue /etc/yum.repos.d/mongo.repo

#Setup SystemD Catalogue Service
cp 03.catalogue.service /etc/systemd/system/catalogue.service

#Install NodeJS, By default NodeJS 16 is available, We would like to enable 20 version and install list.
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
#Install NodeJS
dnf install nodejs -y
#Configure the application.
#Add application User
useradd roboshop
#Remove Directory and re create it
rm -rf /app
#Lets setup an app directory.
mkdir /app
#Download the application code to created app directory.
rm -rf /tmp/
.zip
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip
#Lets download the dependencies.
cd /app
npm install


#Load the service.
systemctl daemon-reload

#Start the service.
systemctl enable catalogue
systemctl start catalogue


#install mongo.repo
dnf install mongodb-mongosh -y
#Load Master Data of the List of products we want to sell and their quantity information also there in the same master data.
mongosh --host mongodb-dev.azdevopsvenkat.site </app/db/master-data.js