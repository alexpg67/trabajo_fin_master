En este repositorio se encuentran todos los códigos realizados durante el Trabajo Fin de Máster titulado *Diseño e implementación de un sistema antifraude en redes de telecomunicación basado en la especificación de API Open Gateway*.


# Open Gateway

Open Gateway es un proyecto es un proyecto que va a permitir a las operadoras de telecomunicaciones, exponer sus capacidades de forma estandarizada a terceros a través de APIs. Durante este trabajo, se van a desarrollar tres de las API de Open Gateway. Concretamente, Sim Swap (v 0.4.0), Device Status (v 0.4.1) y Know Your Customer (v 0.1.0). Las definiciones de estas API se pueden encontrar en el repositorio oficial de CAMARA.

# Arquitectura de la solución

El desarrollo cuenta no solo con las API propiamente dichas sino que también con plataformas que permiten la monitorización de métricas, centralización de logs, control de acceso y un punto único de entrada mediante un API GW. Esto va aEl objetivo es conocer quién accede a los servicios, cuál es el comportamiento y el rendimiento de los mismos y mejorar la gestión de las API. La arquitectura de la solución es la siguiente:

![Arquitectura implementada](implementacionarquitecturaogw.png)


Como se puede ver, se despliega una base de clientes de Mongo que contiene toda la información necesaria para exponer las API de Open Gateway. Se supone que la información de esta base es actualizada desde una operadora de telecomunicaciones. La base cuenta con una información inicial de 100 clientes ficticios. Las API se han desarrollado con Spring Boot y la montirozación de métricas se implementa con Grafana y Prometheus. Para la centralización de los logs de todos los microservicios se ha utilizado ELK y para el servidor de autorización keycloak. En cuanto al API GW se usa Kong y Konga para gestionarlo. Se implementa también una web para la gestión de la base de clientes y para tener un enotrno gráfico de pruebas de las API. 
