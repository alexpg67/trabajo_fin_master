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
