# OpenJDK está deprecado
FROM eclipse-temurin:21

WORKDIR /app

# Copia el archivo JAR empaquetado al contenedor
COPY ./kyc-0.0.1-SNAPSHOT.jar /app/kyc-0.0.1-SNAPSHOT.jar

# Expone el puerto en el que tu aplicación escucha
EXPOSE 8085

# Comando para ejecutar tu aplicación
CMD ["java", "-jar", "/app/kyc-0.0.1-SNAPSHOT.jar"]