# Actualizamos los repositorios del sistema
sudo apt update -y

# Instalamos el servidor MySQL
sudo apt install mysql-server -y

# Instalamos phpMyAdmin para gestionar MySQL desde una interfaz web
sudo apt install -y phpmyadmin

# Configuramos MySQL para que escuche en la IP específica del servidor
sudo sed -i "s/^bind-address\s*=.*/bind-address = 10.0.3.139/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio MySQL para aplicar los cambios
sudo systemctl restart mysql

# Configuramos la base de datos y el usuario para WordPress
sudo mysql -u root <<EOF
CREATE DATABASE db_wordpress; -- Creamos la base de datos para WordPress
CREATE USER 'Josein'@'10.0.3.%' IDENTIFIED BY '1234'; -- Creamos un usuario para acceder desde la red
GRANT ALL PRIVILEGES ON db_wordpress.* TO 'Josein'@'10.0.3.%'; -- Le damos todos los permisos sobre la base de datos
FLUSH PRIVILEGES; -- Aplicamos los cambios de privilegios
EOF
