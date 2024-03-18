async function getMsisdnClient() {
    const msisdn = document.getElementById('msisdn').value;
    const token = await obtenerToken(); // OJO la configuración de Keycloack.

    if (!token) {
        showResponse({ error: "Error al obtener el token de acceso. Por favor, verifica tus credenciales y la disponibilidad de Keycloak." });
        return;
    }

    try {
        const response = await fetch(`/provision/v0/get/msisdn/${msisdn}`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (!response.ok) {
             const errorData = await response.json(); // Intenta obtener el detalle del error como JSON
             throw new Error(`${JSON.stringify(errorData)}`);
        }

        const data = await response.json();
        showResponse(data);
    } catch (error) {
        showResponse({ error: "Error al obtener los datos del cliente MSISDN. Detalles: " + error.message });

    }
}

async function getEmailClient() {
    const email = document.getElementById('email').value;
    const token = await obtenerToken(); // OJO la configuración de Keycloack.

    if (!token) {
        showResponse({ error: "Error al obtener el token de acceso. Por favor, verifica tus credenciales y la disponibilidad de Keycloak." });
        return;
    }

    try {
        const response = await fetch(`/provision/v0/get/email/${email}`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (!response.ok) {
                   const errorData = await response.json(); // Intenta obtener el detalle del error como JSON
                   throw new Error(`${JSON.stringify(errorData)}`);
        }

        const data = await response.json();
        showResponse(data);
    } catch (error) {
        showResponse({ error: "Error al obtener los datos del cliente Email. Detalles: " + error.message });
    }
}

async function getDniClient() {
    const dni = document.getElementById('dni').value;
    const token = await obtenerToken(); // OJO la configuración de Keycloack.

    if (!token) {
        showResponse({ error: "Error al obtener el token de acceso. Por favor, verifica tus credenciales y la disponibilidad de Keycloak." });
        return;
    }

    try {
        const response = await fetch(`/provision/v0/get/dni/${dni}`, {
            headers: {
                'Authorization': `Bearer ${token}`
            }
        });

        if (!response.ok) {
               const errorData = await response.json(); // Intenta obtener el detalle del error como JSON
               throw new Error(`${JSON.stringify(errorData)}`);
        }

        const data = await response.json();
        showResponse(data);
    } catch (error) {
           showResponse({ error: "Error al obtener los datos del cliente DNI. Detalles: " + error.message });
    }
}

//function showResponse(data) {
//    const apiResponse = document.getElementById('apiResponse');
//    apiResponse.innerHTML = '';
//
//    if (data) {
//        Object.keys(data).forEach(key => {
//            const p = document.createElement('p');
//            p.textContent = `${key}: ${data[key]}`;
//            apiResponse.appendChild(p);
//        });
//    } else {
//        apiResponse.textContent = 'No se recibieron datos del servidor.';
//    }
//}

function showResponse(data) {
    const apiResponse = document.getElementById('apiResponse');
    apiResponse.innerHTML = '';

    // Verificar si data es un array (lista de clientes) o un objeto (cliente individual)
    if (Array.isArray(data)) {
        data.forEach(client => displayClient(client, apiResponse));
    } else if (data) {
        displayClient(data, apiResponse);
    } else {
        apiResponse.textContent = 'No se recibieron datos del servidor.';
    }
}

function displayClient(client, container) {
    // Recorrer las propiedades del cliente y mostrarlas
    Object.keys(client).forEach(key => {
        if (typeof client[key] === 'object' && client[key] !== null) {
            // Para propiedades de objeto anidadas, crea un nuevo contenedor
            const subContainer = document.createElement('div');
            subContainer.textContent = `${key}:`;
            displayClient(client[key], subContainer); // Llamada recursiva para manejar el objeto anidado
            container.appendChild(subContainer);
        } else {
            // Para propiedades no anidadas, simplemente muestra la propiedad y su valor
            const p = document.createElement('p');
            p.textContent = `${key}: ${client[key]}`;
            container.appendChild(p);
        }
    });
}

async function obtenerToken() {
    const detalles = {
        client_id: 'prueba',
        client_secret: '1JsLTnYN3PicBWEZwcY702I8vlAaeyNs',
        grant_type: 'client_credentials'

    };

    const formBody = Object.keys(detalles).map(key => encodeURIComponent(key) + '=' + encodeURIComponent(detalles[key])).join('&');


    try {
        const respuesta = await fetch('http://localhost:8080/realms/Test/protocol/openid-connect/token', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' // Importante el formato
            },
            body: formBody
        });

        const data = await respuesta.json();


        return data.access_token;
    } catch (error) {
        console.error('Error obteniendo token de Keycloak:', error);
    }
}