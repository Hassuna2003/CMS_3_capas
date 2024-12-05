# Actualizamos repositorios
sudo apt update -y

# Instalamos el servidor NFS
sudo apt install nfs-kernel-server -y


sudo apt install nfs-kernel-server -y
sudo apt install unzip -y
sudo apt install curl -y
sudo apt install php php-mysql -y
sudo apt install mysql-client -y

sudo mkdir -p /var/nfs/compartir

sudo chown nobody:nogroup /var/nfs/compartir 

sudo sed -i '$a /var/nfs/compartir    10.0.2.0/24(rw,sync,no_subtree_check)' /etc/exports

sudo curl -O https://wordpress.org/latest.zip

sudo unzip -o latest.zip -d /var/nfs/compartir/
