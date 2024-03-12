async function createClient() {
    const token = await obtenerToken(); // Usa la misma función para obtener el token

    if (!token) {
        showResponse({ error: "Error al obtener el token de acceso. Por favor, verifica tus credenciales y la disponibilidad de Keycloak." });
        return;
    }
//    const clientData = {
//        msisdn: "+34611329336",
//        imsi: "214072145678861",
//        mcc: 214,
//        mnc: "07",
//        cellId: "1299",
//        titular: false,
////        titular: false,
//        titularData: {
//            name: document.getElementById('name').value,
//            givenName: document.getElementById('givenName').value,
//            familyName: document.getElementById('familyName').value,
//            idDocument: document.getElementById('idDocument').value,
//            email: document.getElementById('email').value,
//            gender: document.getElementById('gender').value,
////            birthdate: document.getElementById('birthdate').value,
//            birthdate: "1990-05-15",
//            address: {
//                streetName: document.getElementById('streetName').value,
//                streetNumber: document.getElementById('streetNumber').value,
//                postalCode: document.getElementById('postalCode').value,
//                region: document.getElementById('region').value,
//                locality: document.getElementById('locality').value,
//                country: document.getElementById('country').value,
//                houseNumberExtension: document.getElementById('houseNumberExtension').value,
//            }
//        },
//        latestSimChange: ""
//    };
    const clientData = {
        msisdn: document.getElementById('msisdn').value,
        imsi: document.getElementById('imsi').value,
        mcc: parseInt(document.getElementById('mcc').value, 10),
        mnc: document.getElementById('mnc').value,
        cellId: parseInt(document.getElementById('cell_id').value, 10),
        titular: document.getElementById('titular').checked,
//        titular: false,
        titularData: {
            name: document.getElementById('name').value,
            givenName: document.getElementById('givenName').value,
            familyName: document.getElementById('familyName').value,
            idDocument: document.getElementById('idDocument').value,
            email: document.getElementById('email').value,
            gender: document.getElementById('gender').value,
            birthdate: document.getElementById('birthdate').value,
            address: {
                streetName: document.getElementById('streetName').value,
                streetNumber: document.getElementById('streetNumber').value,
                postalCode: document.getElementById('postalCode').value,
                region: document.getElementById('region').value,
                locality: document.getElementById('locality').value,
                country: document.getElementById('country').value,
                houseNumberExtension: document.getElementById('houseNumberExtension').value,
            }
        },
        latestSimChange: ""
    };

    try {
        const response = await fetch('http://localhost:8082/provision/v0/newclient', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${token}`
            },
            body: JSON.stringify(clientData)
        });

        if (!response.ok) {
            const errorData = await response.json();
            throw new Error(`${JSON.stringify(errorData)}`);
        }

        const data = await response.json();
        showResponse(data);
    } catch (error) {
        showResponse({ error: "Error al crear el cliente. Detalles: " + error.message });
    }
}

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
        client_secret: 'B66pt014puIUMFoOUVIKpPBcbrgWGTua',
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