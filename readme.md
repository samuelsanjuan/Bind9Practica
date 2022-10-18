# SRI PRACTICA 1

## Volumen por separado de la configuración

## Red propia interna para todos los contenedores

##  ip fija en el servidor

## Configurar Forwarders

## Crear Zona propia
  Registros a configurar: NS, A, CNAME, TXT, SOA

## Cliente con herramientas de red

---
Lo que hacemos primero es el archivo docker-compose.yml 

![docker-compose.yml](https://raw.githubusercontent.com/samuelsanjuan/Bind9Practica/master/dockercompose.png)

vemos que tiene dos volumenes distintos para zonas y para configuracion

tambien vemos que tiene la ipv4 fija: 192.168.0.2

---
Para hacer una network tendremos que poner el siguiente comando en una terminal 

~~~
docker network create --driver=bridge --subnet=192.168.0.0/24 bind9_subnet
~~~
y para añadir los contenedores a la network lo tendremos que añadir al docker-compose.yml poniendole el tag de networks la network 

---
Para configurar los forwarders nos vamos al archivo options de la configuracion y ponemos
~~~
options {

    directory "/var/cache/bind";

    forwarders {
        8.8.8.8;
        8.8.4.4;
    };
    forward only;
    listen-on { any; };
    listen-on-v6 { any; };
    allow-query { 
        any; 
    };
};

~~~
---
configurar zona propia, en el archivo de las zonas escribimos lo siguiente
~~~
$TTL    3600
@       IN      SOA     ns.danielcastelao.com. ssanjuanandres.danielcastelao.org. (
                   2022181002           ; Serial
                         3600           ; Refresh [1h]
                          600           ; Retry   [10m]
                        86400           ; Expire  [1d]
                          600 )         ; Negative Cache TTL [1h]
;
@       IN      NS      ns.danielcastelao.com.
@       IN      MX      10 ssanjuanandres.danielcastelao.org.

ns      IN      A       10.1.0.101
etch    IN      A       10.1.0.5


pop     IN      CNAME   ns
www     IN      CNAME   etch
mail    IN      CNAME   etch

~~~

---

cliente con herramientas de red

dentro de la terminal del cliente hacemos:
~~~ 
sudo apt intall net-tools
~~~