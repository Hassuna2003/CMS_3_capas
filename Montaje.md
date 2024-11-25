# Creación de una infraestuctura en 3 capas para el despliegue de Wordpress.

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

a) Creamos el grupo de seguridad para el balanceador, añadiendo reglas de entrada para HTTP y HTTPS.

Regla 1 (permitir acceso desde cualquier IP).

![image](https://github.com/user-attachments/assets/d312bbdd-2b18-48f8-a184-dba6491eff52)

Regla 2 (permitir acceso desde cualquier IP).

![image](https://github.com/user-attachments/assets/79cd9a26-c1e1-4e4f-8e16-eec86d289ae3)

Regla de salida (permitir salida a cualquier destino).

![image](https://github.com/user-attachments/assets/7461ed74-11ee-47bf-8399-d4c6cd1124a1)

b) Crear grupo de seguridad para el Backend y NFS.

Regla 1 (permitimos que el balanceador se comunique con los Backend).

![image](https://github.com/user-attachments/assets/1ceadf3e-d399-4f91-983e-3405af60b7ca)

Regla 2 (hacemos una autorreferencia al grupo para que se comunique el Backend y NFS).

![image](https://github.com/user-attachments/assets/647982f6-7c60-42a9-b693-3192be4b3fb5)

Regla 3 (el servicio NFS (Network File System) utiliza el puerto 111 para coordinar la comunicación entre clientes y servidores).

![image](https://github.com/user-attachments/assets/8c9a6cf1-622a-4b92-bf37-297dcd583c90)

Regla de salida (permitir salida a cualquier destino).

![image](https://github.com/user-attachments/assets/e42da58f-f305-41e9-9f05-cca50cf2632d)

c) Crear grupo de seguridad para la base de datos.

Regla de entrada 1 (aseguramos que solo los servidores de Backend puedan acceder a la base de datos).

![image](https://github.com/user-attachments/assets/80be8200-f898-4155-b875-4b1ca4ef3b51)

Regla de salida (permitir salida a cualquier destino).

![image](https://github.com/user-attachments/assets/cb8c2e12-35f8-4582-818c-3e3a0d35d7ae)

7. Crear las instancias:

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


