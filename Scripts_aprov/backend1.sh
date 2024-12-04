# Actualizamos repositorios
sudo apt update -y

# Instalamos apache, que lo usaremos como balanceador de carga
sudo apt install apache2 -y

# Instalamos el cliente para el servidor NFS
sudo apt install nfs-common -y

# Instalamos php y las dependencias para poder servir la página de wordpress
sudo apt install php libapache2-mod-php php-mysql php-curl php-gd php-xml php-mbstring php-xmlrpc php-zip php-soap php-cli php-fpm php-bcmath php-intl -y
