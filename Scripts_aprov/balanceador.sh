# Actualizamos repositorios
sudo apt update -y

# Instalamos apache, que lo usaremos como balanceador de carga
sudo apt install apache2 -y

# Configurar el servidor web Apache como proxy inverso. Tenemos que activar estos módulos como mínimo
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2enmod proxy_balancer

# Este método de balanceo de carga consiste en distribuir las peticiones entre los servidores de forma secuencial, de forma que cada vez que llegue una nueva petición se envía al siguiente servidor de la lista de servidores configurados en el servidor Apache
sudo a2enmod lbmethod_byrequests

# Reiniciamos apache para aplicar cambios
sudo systemctl restart apache2

