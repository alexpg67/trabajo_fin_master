# OpenJDK está deprecado
FROM eclipse-temurin:21

WORKDIR /app

# Copia el archivo JAR empaquetado al contenedor
COPY ./devicestatus-0.0.1-SNAPSHOT.jar /app/devicestatus-0.0.1-SNAPSHOT.jar

# Expone el puerto en el que tu aplicación escucha
EXPOSE 8084

# Comando para ejecutar tu aplicación
CMD ["java", "-jar", "/app/devicestatus-0.0.1-SNAPSHOT.jar"]