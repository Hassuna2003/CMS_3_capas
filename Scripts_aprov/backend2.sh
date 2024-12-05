# Actualizamos repositorios
sudo apt update -y

# Instalamos Apache para usarlo como balanceador de carga
sudo apt install apache2 -y

# Instalamos el cliente NFS para montar directorios remotos
sudo apt install nfs-common -y

# Instalamos PHP y las dependencias necesarias para servir WordPress
sudo apt install php libapache2-mod-php php-mysql php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap php -y

# Creamos una copia de la configuración por defecto de Apache para usarla como base
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web.conf

# Configuramos el directorio raíz para que Apache sirva los archivos de WordPress
sudo sed -i 's|DocumentRoot .*|DocumentRoot /var/nfs/compartir/wordpress|g' /etc/apache2/sites-available/web.conf

# Añadimos permisos para acceder al directorio de WordPress
sudo sed -i '/<\/VirtualHost>/i \
<Directory /var/nfs/compartir/wordpress>\
    Options Indexes FollowSymLinks\
    AllowOverride All\
    Require all granted\
</Directory>' /etc/apache2/sites-available/web.conf

# Montamos el directorio compartido NFS
sudo mount 10.0.2.130:/var/nfs/compartir /var/nfs/compartir

# Deshabilitamos el sitio por defecto de Apache
sudo a2dissite 000-default.conf

# Habilitamos la nueva configuración del sitio web
sudo a2ensite web.conf

# Reiniciamos Apache para aplicar los cambios
sudo systemctl restart apache2

# Recargamos Apache por si hay cambios adicionales pendientes
sudo systemctl reload apache2

# Añadimos la configuración de montaje NFS al archivo fstab para que sea persistente
sudo echo "10.0.2.130:/var/nfs/compartir    /var/nfs/compartir   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee -a /etc/fstab
