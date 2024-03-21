# trabajo_fin_master

El token de acceso es


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

## Git

Cada vez que se hacen cambios en local, se debe actualizar el repositorio. Para ello, es muy comodo utilizar la herramienta de git. Las instrucciones para actualizarlo son (Importante hacerlo dentro de la carpeta que contiene todos los ficheros):

```bash
git status
```
```bash
git pull origin main
```
```bash
git add docker JSON provision simswap

```
```bash
git commit -m "Mensaje que describa el commit"

```

```bash
git push origin main

```
Nota: se han excluido algunos ficheros de la carpeta que no son de interes ya que son documentos o archivos con descargas como keycloack.


Problema con la version 2.50.0 de prometheus. Fixed en la 2.50.1, actualizar docker

https://github.com/grafana/grafana/issues/83515

OJO al introducir ELK. Elastic esta configurado para ocupar 2 GB, pero el limite máximo permitido por docker suele ser ya 2 GB por lo que salta un error 137. Para solucionarlo, se limita el tamño de Elastic tal y como se explica en este foro

https://github.com/10up/wp-local-docker/issues/6

Hay que especificar que no se necesita cluster, sino da un error 78 por falta de memoria

https://github.com/laradock/laradock/issues/1699

Un ejemplo de configuracion de logs ELK

https://codesoapbox.dev/how-to-browse-spring-boot-logs-in-kibana-configuring-the-elastic-stack/

Para el portal web, lo más complejo ha sido poder pedir el token a keycloack desde el frontend de javascript. Problema CORS.

Hay que configurar en el cliente de keycloack Authentication Flow -> Standard Flow y se despliega un menú de web origins. Ahí hayq ue agregar la IP de los servicios permitidos para obtener el token. Si pones * valen todas.

https://keycloak.discourse.group/t/cors-issue-with-keycloak-using-it-in-react-and-web-origins-set/13529

Una vez terminado el portal web, migrar Keycloak y Mongo a docker. Los servicios de spring boot también se deberían ejecutar en un contenedor y pasar el . jar pero para hacer pruebas es un rollo. Migrar lo último los servicios de spring boot. Añadir las APIs de Sim Swap, KYC y Device Status Roaming. Mucho ojo, se ha hecho una expresion regular en SB para que el MSISDn pueda tener o no el símbolo + como input. Sin embargo, como en la base de datos se han guaradado con +, si metes el número sin + da error. Revisarlo. A nivel de arquitectura está pendiente incluir API GW. En caso de que se quiera también notificaciones, faltaría un Kafka. Una vez toda la arquitectura hecha, ver técnicas de CI/CD con jenkins. Despliegue automático con docker compose. Una vez funciona, pasar a minikube con helm y los deployment y service asociados. Con todo corriendo, hacer app android sencilla para demostrar casos de uso.

Para hacer el API de Device Status con la versión 0.4.1 en la que se incluye el país en el que el usuario está en roaming, se necesita una base de datos que consultar esta infromación. Para ello, se elige redis que es una BBDD clave valor muy rápida. Lo que hemos hecho es descargar de aquí https://github.com/pbakondy/mcc-mnc-list/blob/master/mcc-mnc-list.json toda la información de MCC/MNC de los paises. A partir de ahí, se ha hecho un script en el que se obtiene un fichero .txt con mcc-pais (clave valor) listo para insertar en redis. Con esto, se ha hecho un dockerfile para tener ya la base de datos de redis con la información precargada. OJO que hay claves de Estados unidos repetidas (Cayman, Estados Unidos, y otras más) solo se tiene en cuenta la ultima. No es relevante porque el país sigue siendo USA en todos los casos.

Se construye la imagen con 

sudo docker build -t alejandropalmier/redis_mcc_database:1.0 .

sudo docker run --name test-redis -d alejandropalmier/redis_mcc_database:1.0 (Se comprueba que esta todo en orden)

sudo docker exec -it test-redis sh

redis-cli

get 214

Salimos de la bbdd

sudo docker stop 6d8bc140af25

Finalmente hacemos push a docker hu

sudo docker login

sudo docker tag alejandropalmier/redis_mcc_database:1.0 alejandropalmier/redis_mcc_database:v1

sudo docker push alejandropalmier/redis_mcc_database:v1

Test unitarios del servicio de check de sim swap?? Echarle un ojo


OJO, cuidado con la configuración de Prometheus. Aunque expongas las metricas de tus MS con la dependecia de microemter y actuator, le tienes que decir a Prometheus que haga queries a esas direcciones.

Cuando cambies todo a contenedores, tienes que cambiar los localhost a los nombres de contenedor. Cuidado.


OJO en el codigo de KYC.

Para aumentar el % de matches se ha tenido en cuenta lo siguiente:

DNI
Se quitan los espacios en blanco
Se cogen los 20 primeros digitos para evitar problemas.
Se pone todo minuscula y se compara.
Creo que funciona correctamente.

Nombres
Se quitan los espacios en blanco
Se cogen los 40 primeros digitos
Se pone en minuscula
Se quitan acentos y otros caracteres especiales
Se quita cualquier caracter no alfanumerico (minuscula)
Se compara
Creo que funciona correctamente.

Calles
Se cogen los 40 primeros digitos. (no se puede eliminar primero los espascios en blanco porque vamos a eliminar el nombre de algunas calles)
Se convierte a minuscula
Se quitan acentos y otros caracteres especiales.
Se elimina palabras como (calle, carreteras, crta, avenida, avd, via, etc)
Se elimina cualquier caracter alfanumerico.
Se compara.
Aquí hay un corner case qque no me gusta. Si los string a compara son iguales salvo espacios en blanco distintos (cuenta como un caracter) y se pasan de 40 de largo, se van a coger subsecuencias que si que son distintas.
Se resuelve facil si aumentamos el máximo largo permitido (ej:60) Creo que no hay ninguna calle de 60 caracteres en españa (Ni siqueira de 40 pero bueno).

Para visualizar el swagger en nuestra web, hemos seguido los pasos seguidos en stackoverflow

https://stackoverflow.com/questions/46237255/how-to-embed-swagger-ui-into-a-webpage

Se descargan los archivos directamente de la carpeta dict del repositorio de swagger

https://github.com/swagger-api/swagger-ui/tree/master

Para que desde la web se pueda acceder a las APIs y evitar problemas de CORS, hay que añadir la siguiente etiqueta
@CrossOrigin(origins = "http://localhost:8082")


Para la migración de docker, cuidado con las rutas relativas. Los localhost van ad ejar de funciona rya que vamos a encapsular la APP en imagenes docker por lo que localhost va a hacer referencia al propio contenedor.

En keycloack lo que tenemos hasta ahora (descarga local) son dos cliente opengateway-test y prueba.
Prueba es el ideal.

Ver su configuracion

Ahi esta el client secret y client scope

client secret

B66pt014puIUMFoOUVIKpPBcbrgWGTua

El nuevo client secret es

1JsLTnYN3PicBWEZwcY702I8vlAaeyNs

Ya he migrado Keycloak a contenedores. No he conseguido importar el Realm de local así que lo he vuelto a hacer a Mano.

Creamos el Realm.

Creamos el Cliente

OJO!!
Valid Redirect URIs: http://localhost:8082/*
Web Origins: * ( Esto es un poco inseguro pero evitamos CORS en la solicitud javascript para obtener el token)
Authentication Flow -> Standard Flow y Service Account Roles ( Nos permite usar token en lugar de usuario y contraseña)
Login Them Keycloak

Por último, creamos el usuario. Usuario y contraseña que queramops.

Si usamos, client credentials, hay que usar en spring boot 
spring.security.oauth2.client.registration.external.client-secret=1JsLTnYN3PicBWEZwcY702I8vlAaeyNs
Antes con el modo Direct Access Grants no hacía falta (Tenía la configuración rara, un cliente para las APIs, con usuario y contraseña y client credentials en el JS).

Para levantar keycloak con docker he usado la imagen de bitnami con alguna configuración de administración. Para persisitir los datos he usado Postgre. He usado la oficial en lugar de la de bitnami porque la de bitnami ha dado problemas. OJO, en todas las capretas asignar permisos sudo chmod -R 777 ./postgresql.

El siguiente paso, era incluir el API-GW. En principio, Kong por ser muy usado en la comunidad. La idea es que la autenticación la haga directamente el API GW y así nos ahorramos poner la configuración en todas las APIs. Lejos de ser sencillo, ha sido muy problematico. Las versiones 3.x.x y superiores de kong han deprecado BasePlugin por lo que se puede instalar en el dockerfile el plugin pero al introducir en el docker compose       KONG_PLUGINS: bundled,oidc , salta error.

https://devops.stackexchange.com/questions/16944/setting-up-keycloak-with-kong-v5-1

Una vez aclarado, esto. Se ha conseguido instalar el plugin con la versión, aún soportada, 2.8.4.Para comprobarlo, podemos hacer:

curl -s http://localhost:8101 | jq .plugins.available_on_server.oidc
curl http://localhost:8101/plugins/enabled

A nivel de coker compose no requiere excesiva complejidad. Se ha creado una imagen que tenga ya descargado el plugin de oidc.

OJO!!
Para la migracion de docker compose a kubernetes, lo suyo es usar Kompose. Cuidado porque al ahcer la conversio, los nombres con _(barra baja) los cambia por guion ya que K8 no soporta nombres con _.

curl -s http://localhost:8080/realms/Test/.well-known/openid-configuration

172.17.0.1

Para manejar mejor a KONG, se puede instalar una UI llamada Konga. Konga es muy útil y está muy bien pero es muy dificil de instalar con persitencias (base de datos postgresql). El motivo es que Konga no soporta postgresql en versiones posteriores a la 12. Por este motivo, hemos usado la 11. Además, hay que ejecutar previamente un contenedor de migración. Adjunto líneas usadas

sudo docker compose up -d konga-database

docker run --rm   --network container:konga-database   pantsel/konga:0.14.9 -c prepare -a postgres -u postgresql://konga:konga@konga-database:5432/konga

sudo docker compose up -d konga

Estaría mejor usar esto en docker compose

  konga-prepare:
    image: pantsel/konga:0.14.9
    command: "-c prepare -a postgres -u postgresql://konga:konga@konga-database:5432/konga"
    restart: on-failure
    links:
      - kong-database
    depends_on:
      - kong-database



