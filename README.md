# trabajo_fin_master

El token de acceso es

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

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

