# Usa la imagen oficial de Redis
FROM redis:7.2.4

# Copia tu archivo txt y el script de carga en el contenedor
COPY mcc_country_redis_import.txt /data/mcc_country_redis_import.txt
COPY load-data.sh /usr/local/bin/load-data.sh

# Da permisos de ejecución al script
RUN chmod +x /usr/local/bin/load-data.sh

# Configura el contenedor para ejecutar tu script personalizado al inicio
CMD ["/usr/local/bin/load-data.sh"]