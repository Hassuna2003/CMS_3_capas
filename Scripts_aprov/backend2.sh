# Actualizamos repositorios
sudo apt update -y

# Instalamos apache, que lo usaremos como balanceador de carga
sudo apt install apache2 -y

# Instalamos el cliente para el servidor NFS
sudo apt install nfs-common -y

# Instalamos php y las dependencias para poder servir la página de wordpress
sudo apt install php libapache2-mod-php php-mysql php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap php -y

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web.conf

sudo sed -i 's|DocumentRoot .*|DocumentRoot /var/nfs/compartir/wordpress|g' /etc/apache2/sites-available/web.conf

sudo sed -i '/<\/VirtualHost>/i \
<Directory /var/nfs/compartir/wordpress>\
    Options Indexes FollowSymLinks\
    AllowOverride All\
    Require all granted\
</Directory>' /etc/apache2/sites-available/web.conf

sudo mount 10.0.2.130:/var/nfs/compartir /var/nfs/compartir

sudo a2dissite 000-default.conf

sudo a2ensite web.conf

sudo systemctl restart apache2

sudo systemctl reload apache2

sudo echo "10.0.2.130:/var/nfs/compartir    /var/nfs/compartir   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" | sudo tee -a /etc/fstab
