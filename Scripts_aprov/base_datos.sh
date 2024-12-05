
sudo apt update -y

sudo apt install mysql-server -y
sudo apt install -y phpmyadmin
sudo sed -i "s/^bind-address\s*=.*/bind-address = 10.0.3.139/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

sudo mysql -u root <<EOF
CREATE DATABASE db_wordpress;
CREATE USER 'Josein'@'10.0.3.%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'Josein'@'10.0.3.%';
FLUSH PRIVILEGES;
EOF
