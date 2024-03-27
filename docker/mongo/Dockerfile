# Usa la imagen oficial de MongoDB
FROM mongo:7.0.7

# Copia tu archivo JSON y el script de carga en el contenedor
COPY generated_clients.json /data/generated_clients.json
COPY load-mongo-data.sh /usr/local/bin/load-mongo-data.sh

# Da permisos de ejecución al script
RUN chmod +x /usr/local/bin/load-mongo-data.sh

# Configura el contenedor para ejecutar tu script personalizado al inicio
CMD ["/usr/local/bin/load-mongo-data.sh"]