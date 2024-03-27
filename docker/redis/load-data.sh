#!/bin/sh

# Inicia el servidor de Redis en segundo plano
redis-server &

# Espera un momento para que Redis se inicie completamente
sleep 10

# Carga los datos desde tu archivo .txt en Redis
redis-cli < /data/mcc_country_redis_import.txt

# Mantiene el contenedor en ejecución
wait
