cp 11.dispatch.service /etc/systemd/system/dispatch.service

#Install GoLang
dnf install golang -y
#Add application User
useradd roboshop
#Lets setup an app directory.
mkdir /app
#Download the application code to created app directory.
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app
unzip /tmp/dispatch.zip
#Lets download the dependencies & build the software.
cd /app
go mod init dispatch
go get
go build
#Load the service.
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch