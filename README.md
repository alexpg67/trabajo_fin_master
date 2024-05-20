ACTUALIZAR LA APP DE OGW SIN APIS. LA DEL REPO NO FUNCIONA.

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

Para manejar mejor a KONG, se puede instalar una UI llamada Konga. Konga es muy útil y está muy bien pero es muy dificil de instalar con persitencias (base de datos postgresql). El motivo es que Konga no soporta postgresql en versiones posteriores a la 12 (https://github.com/pantsel/konga/issues/487). Por este motivo, hemos usado la 11. Además, hay que ejecutar previamente un contenedor de migración. Adjunto líneas usadas

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


Otra sugerencia es esta:

services:
  konga-database:
    image: postgres:11.0
    container_name: konga-database
    volumes:
      - ./kongadb:/var/lib/postgresql/data
    ports:
      - "5434:5432"
    environment:
      POSTGRES_DB: konga
      POSTGRES_USER: konga
      POSTGRES_PASSWORD: konga
    restart: unless-stopped

  konga-prepare:
    image: pantsel/konga:0.14.9
    container_name: konga-prepare
    command: sh -c "while ! nc -z konga-database 5432; do sleep 1; done && konga -c prepare -a postgres -u postgresql://konga:konga@konga-database:5432/konga"
    depends_on:
      - konga-database
    restart: on-failure

  konga:
    image: pantsel/konga:0.14.9
    container_name: konga
    restart: always
    environment:
      DB_ADAPTER: postgres
      DB_HOST: konga-database
      DB_PORT: 5432
      DB_USER: konga
      DB_PASSWORD: konga
      DB_DATABASE: konga
      NODE_ENV: production
    ports:
      - "1337:1337"
    depends_on:
      - konga-database

Para instalar el nuevo plugin

sudo docker cp /home/alejandro/TFM/docker/kong/keycloak-introspection kong:/usr/local/share/lua/5.1/kong/plugins

sudo docker cp /home/alejandro/TFM/docker/kong/kong.conf kong:/etc/kong/kong.conf

sudo docker restart kong

He tenido que volver a la version más reciente y borrar la base de datos que había porque aunque se cargaban los ficehros correctamente, no se veía que estaba activo a traves de las APIs de Kyecloak.

He puesto en docker compose la migración necesaria, pero cuidado porque solo se necesita la priemra vez.

Se ha conseguido gracias al tutorial de https://www.youtube.com/watch?v=5OgjqaFVVrI

Los pasos han sido:

Instalar kong, konga y keycloak con docker compose.

Crear los servicios y rutas en kong.

Añadir el nuevo plugin en kong con los pasos descritos previamente.

Añadir mediante API (Postman) el plugin en el servicio creado,

Muy satisfecho con el resultado, el script de lua se puede seguir modificando sobre todo para los errores.

Al final se ha conseguido.

La unica duda que me queda es
como es posible que al pedir un token a keycloak en estos dos endpoint
http://172.17.0.1:8080/realms/Test/protocol/openid-connect/token
http://localhost:8080/realms/Test/protocol/openid-connect/token
Los token sean difernetes y uno no valida el token del otro cuando son la misma instancia?

El siguiente paso es migrar mongo a contenedor.

Para ello, necesitamos una base de datos más grande, solo teníamos 10 clientes. Vamos a realizar un script para tener al menos 100.

En el script, vamos a necesitar introducir nombres, apellidos y calles como una lista. El resto de campos se pueden generar aleatoriamente.

El script genera los campos en base a:

msisdn: Genera números pseudoaleatorios -> +346514812XX donde XX serán numeros del 00 al 99. generando 100 numeros.

imsi: Estrategia similar a msisdn. Teniendo en cuenta que el mcc y mnc de telefonica España es 214 y 07 respectivamente. Se generan 100 imsis de 214071234567800 a 214071234567899.

mcc:Elige uno de los mcc que hay en redis. En vez de hacer logica con redis, directamente copiamos una lista al script de los mcc disponibles. No todos los usuarios están en roaming, hemos generado que haya solo 15 en roaming, el resto tendran mcc 214.

mnc: Si esta en roaming es aleatorio, sino es 07.

cell_id: Numero aleatorio

titular: 75% titulares 25 % reciclados (Hijos de titular o similar de los que se desconoce informacion)

idDocument: pseudo aleatorio 08359 random (100-999) y letra aleatoria

email: Se forma con el nombre y añadiendo gmail como extensión.

gender: random masculino o femenino.

birthdate: año aleatorio de 1924 a 2006 (mayor de edad), día aleatorio de 01 a 30 y mes aleatorio de 01 a 12.

house_number_extension: Refleja el piso, he considerado que puede que no haya piso (20%) y fuese un chalet entonces se deja vacío. Si hay piso, se coge un número aleatorio entre 1 y 3 (planta) y letra de la A la F (piso)

latestSimChange: Aleatorio de 2020 a 2024. si es 2024 el mes no puede ser posterior a Abril.






Estoy satisfecho con el resultado. Se ha creado una imagen a través de un Dockerfile y un script que es la base de mongo con los elementos precargados.

OJO al hacer el Dockerfile de la migración. Yo quería que los datos estuviese precargados en la base de datos. Para ello, hice un dockerfile que ejecuta este script.

#!/bin/sh


mongod --fork --logpath /var/log/mongodb.log --bind_ip_all -> Permite arrancar mongod, sin esto no deja ni hacer mongosh al entrar al contenedor. La opcion de bind ip permite que escuhe en todos los interfaces de red, no solo en localhost. Esto es importante porque sino no funciona bien ya que localhost es la del contenedor. Con la imagen oficial de mongo sin modificar funcionaba correctamente porque directamente mapea el localhost de mongo con el del ordenador. Con el mongo modificado no es exactamente así.


sleep 10


mongoimport --uri "mongodb://localhost:27017/telecomclients" --collection client_muestra --type json --file "/data/generated_clients.json" --jsonArray

 
tail -f /dev/null -> Si no se elimina el contenedor al ejecutar el script.




Para probar el resultado

sudo docker build -t alejandropalmier/mongodb-telecomclients:2.0 .

sudo docker run --name test-mongo -d alejandropalmier/mongodb-telecomclients:2.0

sudo docker exec -it test-mongo sh

sudo docker stop (id del proceso)

Lo subimos a la cuenta de dockerhub

Hay un problema que es un poco incomodo. Se puede sobrepasar y quizás cuando termine toda la configuración lo hago. La cosa es que al pedir el token a keycloak, se pide a la URL publica (en local localhost), mientras que a Kong se le dice que lo autentique a 172.17.0.1 (IP para que un contenedor acceda fuera del mismo), esto provoca que el iss no coincida y que por lo tanto, devuelva un false keycloak. Esto se resuelve pidiendo el token a 172.17.0.1 y no a localhost. No me gusta, por eso he intentado cambiar el hostname para que sea siempre uniforme. Esto se hace a traves de la variable de entorno:

KEYCLOAK_HOSTNAME: "keycloak"

Sin embargo, hay un bug, decrito aqui https://github.com/bitnami/containers/issues/51498. básicamente se queda la interfaz web cargando constantemene incluso habiendo modificado elf icher /etc/hosts para que resuelve el nombre keycloak. La solución pone que es borrar la DB ya que el hostname se guarda solo una vez.

Me ha dado muchos dolores de cabeza conectar el contenedor de devicestatus con redis. Si uso en la configuración localhost, funciona correctamente. Cuando ponía el nombre del contenedor docker no funcionaba. Tras haber comprobado instalando en el conteendor de devicestatus telnet ping y redis-cli que si que hay conectividad, he encontrado este hilo en github de alguien con el mismo problema.

https://github.com/spring-projects/spring-boot/issues/38774

Esto se explica aqui:
https://www.baeldung.com/spring-data-redis-properties

Para la versión (3.x) de spring boot, que es la que estoy usando porque es la actual, hay que usar

spring.data.redis.host=localhost
spring.data.redis.port=16379

En lugar de:

spring.redis.host=localhost
spring.redis.port=16379

Efectivamente, ese era el problema (Solucionado!!)

Una vez hemos terminado el despliegue con docker compose, vamos a ir a por kubernetes. Vamos a usar por el momento minikube. Para instalarlo seguimos los pasos de la web oficial:

https://minikube.sigs.k8s.io/docs/start/

Al arrancarlo con minikube start me daba error:

minikube start
😄  minikube v1.32.0 en Ubuntu 22.04 (vbox/amd64)
👎  Unable to pick a default driver. Here is what was considered, in preference order:
    ▪ docker: Not healthy: "docker version --format {{.Server.Os}}-{{.Server.Version}}:{{.Server.Platform.Name}}" exit status 1: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/version": dial unix /var/run/docker.sock: connect: permission denied
    ▪ docker: Sugerencia: Add your user to the 'docker' group: 'sudo usermod -aG docker $USER && newgrp docker' <https://docs.docker.com/engine/install/linux-postinstall/>
💡  Alternativamente, puede installar uno de estos drivers:
    ▪ kvm2: Not installed: exec: "virsh": executable file not found in $PATH
    ▪ podman: Not installed: exec: "podman": executable file not found in $PATH
    ▪ qemu2: Not installed: exec: "qemu-system-x86_64": executable file not found in $PATH
    ▪ virtualbox: Not installed: unable to find VBoxManage in $PATH

Para solucionarlo:

Minikube intenta usar Docker como el controlador (driver) por defecto. El mensaje de error sugiere que tu usuario actual no tiene los permisos adecuados para comunicarse con el demonio de Docker. Para resolver esto, puedes agregar tu usuario al grupo docker con el siguiente comando:

sudo usermod -aG docker $USER

newgrp docker

Tenemos que instalar también kubectl, siguiendo tambien los pasos de la web oficial

https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

Las versiones que estoy usando es 

v1.28.3 Kubernetes
v1.29.3 Kubectl


Vale, para el despliegue en kubernetes es muy importante el tema de persisistir los datos en volumenes sobre todo para Elastic, Prometheus/Grafana, Kong (Postgres), Konga (Postgres) y Keycloak (Postgres). Si no somos capaces de persisitir la información, cada vez que se arranque el escenario hay que configurar todo (dashboards, índices, rutas, servicios, clientes, usuarios, realms, etc). Con kompose, lo que se generan son PVCs por cada volumen de docker. La estrategia de PVCs está muy bien en cluster de más de un nodo ya que permite que pods en diferentes máquinas compartan los datos sin depende del sistema de ficheros del host. Con minikube, cuando creas un PVC, a través del Storage Class, se crea automaticamente un PV que cumple las carácterisiticas del PVC. Sin embargo, cuando eliminas el escenario (borras los PVcs), los volumenes desaparecen por como está configurado el Storage Class:

 kubectl get storageclass
NAME                 PROVISIONER                RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
standard (default)   k8s.io/minikube-hostpath   Delete          Immediate           false                  72m

La ReclaimPolicy debería ser Retain. Para soplucionar esto, tenemos dos estrategias. O crear un storage class tipo Retain y asociar los PVCs a este nuevo storage class y no al por defecto de minikube. La otra opción es directamente especificar un volumen de tipo hostPath usando las configuraciones y datos que ya se han creado para docker. Realmente, la ventaja que tenía usar PVCs es que kompose los generaba automáticamente y que el escenario es más fácil de portar a un cluster real. Sin embargo, en este momento no hay idea de migración a un cluster real ya que no tenemos muchos créditos en proveedores de cloud. En caso de que finalmente se despliegue en telefónica en el cluster de open Shift, habrá que migrar esta solución de volumenes, por el momento podemos ir con hostPath que es más eficiente.

Si tuviesemos un cluster, lo más fácil es crear un NFS que es básicamente un sistema de archivos compartido. Habría que instalar NFS en el nodo que va a almacenar los datos (NFS "master") crear el directorio compartido y  posteriormente, en los nodos de los pods que van a usar nfs, hay que configurar los PVCs para que apunten a esta máquina NFS (Es ideal que este todo conectyado en la misma red y usar IPs fijas para las maquinas). Dejo aquí un par de tutoriales útiles:

https://www.josedomingo.org/pledin/2019/03/almacenamiento-kubernetes/

https://medium.com/liveness-y-readiness-probe/kubernetes-nfs-server-3fb2c2c00c29

Despues de estar un rato dandole vueltas. Voy a poner aquí algunos learnings. Minikube corre en el host como un contenedor de docker. Cuando tu usas hostPath, se esta refiriendo a la carpeta dentro del contenedor de minikube y no al sistema de archivos del host. Por lo tanto, decidí volver a PVCs configurando un StorageClass de tipo retain. Esto soluciono el problema pero no me encajo del todo ya que guarda los PVs en:

/tmp/hostpath-provisioner/default/elasticsearch-claim0

Por lo que al eliminar y volver a crear el escenario, se vuelven a crear los PVs y PVCs aunque eso sí, la información se ha quedado persisitida. El caso aquí es que los PVCs se crean y se destruyen y por eso se crean nuevos PVs, no se debería recrear los PVCs. La solución más bonita a esto es hacer en el host un servidor NFS y hacer al cluster de minikube el cliente de NFS. Aquí está el tutorial para hacerlo:

https://mikebarkas.dev/setup-nfs-for-minikube-persistent-storage/

Sin embargo, esto es mucho más complejo que simplemente usar hostPath eligiendo la carpeta a usar y cargando si queremos preeviamente los ficheros al contenedor.


kubectl port-forward svc/keycloak 8081:8080
newman run PruebasE2EDeviceStatus.postman_collection.json
sudo docker compose up -d
kubectl apply -f .
systemctl jenkins status

curl -X POST http://localhost:8083/sim-swap/v0/retrieve-date \
-H "Content-Type: application/json" \
-d '{"phoneNumber": "+34651481214"}'

curl -X POST http://192.168.56.101:8083/sim-swap/v0/retrieve-date \
-H "Content-Type: application/json" \
-d '{"phoneNumber": "+34651481214"}'


IP de la VM 192.168.56.101
IP de host 192.168.1.1

http://localhost:8085/kyc-match/v0/match
  {
    "phoneNumber": "+34651481210",
    "idDocument": "08359571V",
    "name": "Sofía Hernández",
    "givenName": "Sofía",
    "familyName": "Hernández",
    "nameKanaHankaku": "",
    "nameKanaZenkaku": "Ｆｅｄｅ",
    "middleNames": "Sanchez",
    "familyNameAtBirth": "YYYY",
    "address": "Carrer De MALlorca 100",
    "streetName": "Carrer de Mallorca",
    "streetNumber": "100",
    "postalCode": "08029",
    "region": "Barcelona",
    "locality": "Barcelona",
    "country": "España",
    "houseNumberExtension": "I",
    "birthdate": "1984-07-25",
    "email": "sofia@example.com",
    "gender": "FEMale"
 

      }

        {
    "msisdn": "+34651481230",
    "imsi": "214071234567830",
    "mcc": 214,
    "mnc": "07",
    "cell_id": 3259,
    "titular": true,
    "titular_data": {
      "name": "Sofía Hernández",
      "givenName": "Sofía",
      "familyName": "Hernández",
      "idDocument": "08359628B",
      "email": "sofiahernandez@gmail.com",
      "gender": "Femenino",
      "birthdate": "1976-09-24",
      "address": {
        "streetName": "Calle de Segovia",
        "streetNumber": "187",
        "postalCode": "28017",
        "region": "Madrid",
        "locality": "Madrid",
        "country": "España",
        "houseNumberExtension": "3E"
      }
    },
    "latestSimChange": "2024-01-07T05:43:34.000Z"
  }

pm.sendRequest({
    url: "http://localhost:8100/realms/TFM/protocol/openid-connect/token",
    method: 'POST',
    headers: {
        'Accept': 'application/json', // Agregado encabezado Accept
        'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: {
        mode: 'urlencoded', 
        urlencoded: [
            {key: "client_id", value: "opengateway"},
            {key: "client_secret", value: "1JsLTnYN3PicBWEZwcY702I8vlAaeyNs"},
            {key: "grant_type", value: "client_credentials"}


        ]
    }
},
(err, res) => {
    if (err) {
        console.log(err);
    } else {
        pm.variables.set("access_token", res.json().access_token);
        console.log("Token: ", res.json().access_token);
        console.log("Token: ", res.json());
        console.log("access_token: ", pm.variables.get("access_token"))
    }
});
