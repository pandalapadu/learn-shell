#Install redis, By default redis 6 is available, We would like to enable 7 version and install list.
dnf module disable redis -y
dnf module enable redis:7 -y
#Install Redis
dnf install redis -y
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis/redis.conf
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
#Start & Enable Redis Service
systemctl enable redis
systemctl start redis