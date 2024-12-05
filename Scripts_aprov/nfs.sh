# Actualizamos repositorios
sudo apt update -y

# Instalamos el servidor NFS
sudo apt install nfs-kernel-server -y

# Instalamos unzip para descomprimir archivos
sudo apt install unzip -y

# Instalamos curl para descargar archivos desde internet
sudo apt install curl -y

# Instalamos PHP y su conector para MySQL
sudo apt install php php-mysql -y

# Instalamos el cliente MySQL
sudo apt install mysql-client -y

# Creamos el directorio para compartir archivos
sudo mkdir -p /var/nfs/compartir

# Damos permisos genéricos al directorio NFS
sudo chown nobody:nogroup /var/nfs/compartir 

# Configuramos la carpeta en el archivo /etc/exports para compartirla con la red
sudo sed -i '$a /var/nfs/compartir    10.0.2.0/24(rw,sync,no_subtree_check)' /etc/exports

# Descargamos WordPress
sudo curl -O https://wordpress.org/latest.zip

# Descomprimimos WordPress en el directorio compartido
sudo unzip -o latest.zip -d /var/nfs/compartir/

# Damos permisos de ejecución al directorio y archivos compartidos
sudo chmod 755 -R /var/nfs/compartir/

# Asignamos como propietario de los archivos al usuario y grupo de Apache
sudo chown -R www-data:www-data /var/nfs/compartir/*

# Reasignamos permisos genéricos al directorio compartido para NFS
sudo chown -R nobody:nogroup /var/nfs/compartir/

# Reiniciamos el servidor NFS para aplicar los cambios
sudo systemctl restart nfs-kernel-server




