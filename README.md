En este repositorio se encuentran todos los códigos realizados durante el Trabajo Fin de Máster titulado *Diseño e implementación de un sistema antifraude en redes de telecomunicación basado en la especificación de API Open Gateway*.


# Open Gateway

Open Gateway es un proyecto es un proyecto que va a permitir a las operadoras de telecomunicaciones, exponer sus capacidades de forma estandarizada a terceros a través de APIs. Durante este trabajo, se van a desarrollar tres de las API de Open Gateway. Concretamente, Sim Swap (v 0.4.0), Device Status (v 0.4.1) y Know Your Customer (v 0.1.0). Las definiciones de estas API se pueden encontrar en el repositorio oficial de CAMARA.

# Arquitectura de la solución

El desarrollo cuenta no solo con las API propiamente dichas sino que también con plataformas que permiten la monitorización de métricas, centralización de logs, control de acceso y un punto único de entrada. La arquitectura de la solución es la siguiente:


