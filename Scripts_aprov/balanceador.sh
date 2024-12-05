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

# Creamos un nuevo archivo de configuración para crear un VirtualHost con la configuración del proxy inverso
sudo bash -c "cat > /etc/apache2/sites-available/load-balancer.conf <<EOL
<VirtualHost *:80>
    <Proxy balancer://mycluster>
        BalancerMember http://10.0.2.226
        BalancerMember http://10.0.2.166
    </Proxy>
    ProxyPass / balancer://mycluster/
</VirtualHost>
EOL"

# Habilitamos el VirtualHost que acabamos de crear
sudo a2ensite load-balancer.conf

# Deshabilitamos el VirtualHost que tiene Apache configurado por defecto
sudo a2dissite 000-default.conf

# Reiniciamos el servicio para aplicar los cambios
sudo systemctl restart apache2

# Reiniciamos el servicio para aplicar los cambios
sudo systemctl reload apache2







