# Creación de una infraestuctura en 3 capas para el despliegue de WordPress.

## Configuración de montaje de las VPC, subredes e instancias.

1. Crear VPC

La IPv4 CIDR Block será 10.0.0.0/16.

![image](https://github.com/user-attachments/assets/dd55d188-c96f-4ce4-81b0-3569a4f7d789)

2. Crear subredes

Creamos las subredes necesarias para cada capa.

![image](https://github.com/user-attachments/assets/97b26f86-d048-4d57-90c0-d1769d917f8a)

3. Crear una puerta de enlace de Internet

Creamos una Gateway para poder tener salida a Internet.

![image](https://github.com/user-attachments/assets/a7f3c90f-c6c9-40ad-a2d0-f7f4b3ed5f4f)

4. Crear las tablas de enrutamiento:

Creamos las tablas de enrutamiento y se las asignamos a las subredes correspondientes (la subred pública a la tabla pública y las subredes privadas a la tabla privada).



![image](https://github.com/user-attachments/assets/a43e7d40-fce4-4a8c-b664-8067f42bc918)


5. Agregamos una ruta a la tabla pública para que tenga salida a Internet.

![image](https://github.com/user-attachments/assets/a4bbba2a-021b-4296-988d-376a5891edf4)

6. Crear los grupos de seguridad:

Grupo del balanceador:

Regla de entrada:
- Todo el tráfico con origen 0.0.0.0/0

Regla de salida: 
- Todo el tráfico con origen 0.0.0.0/0

Grupo del backend + nfs:

Regla de entrada:
- Todo el tráfico con origen 0.0.0.0/0

Regla de salida: 
- Todo el tráfico con origen 0.0.0.0/0

Grupo de la base de datos:

Regla de entrada:
- Todo el tráfico con origen 0.0.0.0/0

Regla de salida: 
- Todo el tráfico con origen 0.0.0.0/0

8. Crear las instancias:

a) Instancia para el balanceador (La imagen del SSOO será Ubuntu 24.04; tipo de instancia: t2.micro; creamos un par de claves; y en la configuración de red establecemos los ajustes mostrados en la imagen debajo).

![image](https://github.com/user-attachments/assets/60b1312b-0b31-4190-998b-7ca9d92910a6)

b) Instancia para el servidor Backend 1 (el primer servidor cliente de NFS. Establecemos la siguiente configuración).

![image](https://github.com/user-attachments/assets/f44cfe30-c8ad-4461-a42c-9192a04539ad)

c) Instancia para el servidor Backend 2 (lo mismo que la instancia del Backend 1).

Se me pasó poner la captura.

d) Instancia para el NFS (solo cambia la configuración de red respecto a las anteriores).

![image](https://github.com/user-attachments/assets/4b15cf9f-2cbf-4bea-8399-8e4130c0c4e7)

e) Instancia para el servidor con la base de datos.

![image](https://github.com/user-attachments/assets/d13fc482-7033-4519-bc96-37d565495c0a)

8. Crear IP elástica.

Creamos una dirección IP elástica y la asignamos al Balanceador.

![image](https://github.com/user-attachments/assets/21c74815-c08e-494b-b588-32b27da634d2)

11. Para que las maquinas en las subredes privadas tengan internet, tenemos que crear una Gateway NAT, asignándola a la subred pública pero añadiendola a la tabla de enrutamiento de las subredes privadas.

![image](https://github.com/user-attachments/assets/8b3b395c-0c48-4105-be99-b7a1bb52cd36)

