#!/bin/sh

# # Inicia el servidor de MongoDB en segundo plano
mongod --fork --logpath /var/log/mongodb.log --bind_ip_all

# Espera un momento para que MongoDB se inicie completamente
sleep 10

# Importa los datos a MongoDB
mongoimport --uri "mongodb://localhost:27017/telecomclients" --collection client_muestra --type json --file "/data/generated_clients.json" --jsonArray

# # Mantiene el contenedor en ejecución
tail -f /dev/null

# La imagen oficial ya debería iniciar el servidor y mantenerlo en ejecucion