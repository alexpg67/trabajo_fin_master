# OpenJDK está deprecado
FROM eclipse-temurin:21

WORKDIR /app

# Copia el archivo JAR empaquetado al contenedor
COPY ./provision-0.0.1-SNAPSHOT.jar /app/provision-0.0.1-SNAPSHOT.jar

# Expone el puerto en el que tu aplicación escucha
EXPOSE 8082

# Comando para ejecutar tu aplicación
CMD ["java", "-jar", "/app/provision-0.0.1-SNAPSHOT.jar"]

