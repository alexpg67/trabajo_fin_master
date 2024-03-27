import json
import random
import unicodedata
from datetime import datetime

# Función para eliminar acentos de una cadena
def strip_accents(s):
    return ''.join(c for c in unicodedata.normalize('NFD', s)
                   if unicodedata.category(c) != 'Mn')

def generate_latest_sim_change(birthdate, min_years=15):
    birth_year = int(birthdate[:4])
    # Establece el año mínimo para latestSimChange añadiendo min_years a birth_year
    min_year = birth_year + min_years
    # Asegúrate de que el año generado esté entre el mínimo y el año actual o un máximo definido
    latest_year = random.randint(min_year, min_year + 5)  # Puedes ajustar el rango según sea necesario
    latest_date = f"{latest_year}-{random.randint(1, 12):02d}-{random.randint(1, 30):02d}"
    return latest_date + "T" + f"{random.randint(0, 23):02d}:{random.randint(0, 59):02d}:{random.randint(0, 59):02d}.000Z"



def generate_latest_sim_change():
    year = random.randint(2020, 2024)
    if year < 2024:
        month = random.randint(1, 12)
    else:
        month = random.randint(1, 4)  # Para 2024, limita el mes a abril o antes
    day = random.randint(1, 30)  # Suponiendo un rango simplificado para el día
    hour = random.randint(0, 23)
    minute = random.randint(0, 59)
    second = random.randint(0, 59)
    return f"{year}-{month:02d}-{day:02d}T{hour:02d}:{minute:02d}:{second:02d}.000Z"



given_names = {
    "Elena": "Femenino", "Juan": "Masculino", "María": "Femenino", "Pedro": "Masculino",
    "Laura": "Femenino", "Carlos": "Masculino", "Sofía": "Femenino", "Javier": "Masculino",
    "Ana": "Femenino", "Alberto": "Masculino", "Marta": "Femenino", "Sergio": "Masculino",
    "Carmen": "Femenino", "Rafael": "Masculino", "Lucía": "Femenino", "Fernando": "Masculino",
    "Isabel": "Femenino", "José": "Masculino", "Patricia": "Femenino", "David": "Masculino",
    "Nerea": "Femenino", "Luis": "Masculino", "Teresa": "Femenino", "Manuel": "Masculino",
    "Julia": "Femenino", "Alejandro": "Masculino", "Beatriz": "Femenino", "Antonio": "Masculino",
    "Sara": "Femenino", "Miguel": "Masculino", "Paula": "Femenino", "Francisco": "Masculino",
    "Eva": "Femenino", "Roberto": "Masculino", "Silvia": "Femenino", "Óscar": "Masculino",
    "Clara": "Femenino", "Diego": "Masculino", "Rocío": "Femenino", "Jorge": "Masculino",
    "Cristina": "Femenino", "Víctor": "Masculino", "Lorena": "Femenino", "Rubén": "Masculino",
    "Alba": "Femenino", "Daniel": "Masculino", "Nuria": "Femenino", "Pablo": "Masculino",
    "Blanca": "Femenino", "Raúl": "Masculino", "Irene": "Femenino", "Álvaro": "Masculino",
    "Diana": "Femenino", "Adrián": "Masculino", "Verónica": "Femenino", "Gabriel": "Masculino",
    "Sandra": "Femenino", "Ángel": "Masculino", "Lidia": "Femenino", "Iván": "Masculino",
    "Mónica": "Femenino", "Samuel": "Masculino", "Raquel": "Femenino", "Gonzalo": "Masculino",
    "Alicia": "Femenino", "Marcos": "Masculino", "Susana": "Femenino", "Joaquín": "Masculino",
    "Andrea": "Femenino", "Mario": "Masculino", "Noelia": "Femenino", "Juan Carlos": "Masculino",
    "Esther": "Femenino", "Álex": "Masculino", "Margarita": "Femenino", "José Luis": "Masculino",
    "Natalia": "Femenino", "Ricardo": "Masculino", "Yolanda": "Femenino", "Hugo": "Masculino",
    "Carla": "Femenino", "Santiago": "Masculino", "Inés": "Femenino", "Félix": "Masculino",
    "Eduardo": "Masculino", "Aitana": "Femenino"
}
family_names = ["García", "Rodríguez", "González", "Fernández", "López", "Martínez", "Sánchez", "Pérez", "Gómez", "Ruiz",
                "Hernández", "Jiménez", "Díaz", "Moreno", "Muñoz", "Álvarez", "Romero", "Alonso", "Gutiérrez", "Navarro",
                "Torres", "Domínguez", "Vázquez", "Ramos", "Gil", "Ramírez", "Serrano", "Blanco", "Molina", "Morales",
                "Suárez", "Ortega", "Delgado", "Castro", "Ortiz", "Rubio", "Marín", "Sancho", "Núñez", "Iglesias", "Medina",
                "Garrido", "Cortés", "Castillo", "Santos", "Lozano", "Guerrero", "Cano", "Prieto", "Méndez", "Cruz",
                "Calvo", "Gallego", "Herrera", "Marquez", "Peña", "Duran", "Vidal", "León", "Merino", "Lorenzo"]


street_names = ["Calle de Serrano", "Avenida de América", "Gran Vía", "Calle de Alcalá", "Paseo de la Castellana",
                "Calle de Fuencarral", "Avenida de la Albufera", "Calle de Bravo Murillo", "Avenida de Betanzos",
                "Calle de Arturo Soria", "Paseo de Recoletos", "Calle de Goya", "Calle de Hortaleza", "Calle de Atocha",
                "Plaza de España", "Calle de Princesa", "Calle Mayor", "Calle de Bailén", "Calle de Toledo",
                "Avenida de Felipe II", "Calle de Velázquez", "Calle de Preciados", "Calle de Segovia", "Calle de la Princesa"]
codigos = [
    417, 274, 228, 609, 340, 622, 202, 630, 645, 655,208, 294, 221, 545, 220, 338, 352, 416, 540, 612,
    617, 714, 342, 404, 310, 311, 420, 418, 734, 621,460, 226, 283, 637, 652, 653, 647, 429, 716, 366,
    266, 401, 216, 344, 425, 553, 732, 255, 631, 640,270, 284, 421, 619, 455, 248, 607, 346, 244, 550,
    618, 606, 436, 541, 724, 286, 427, 722, 457, 400,231, 372, 642, 212, 505, 712, 552, 292, 641, 551,
    360, 247, 424, 657, 546, 515, 736, 313, 365, 364,350, 413, 214, 376, 238, 470, 472, 525, 437, 610,
    520, 467, 627, 650, 218, 295, 280, 278, 259, 234,628, 626, 740, 419, 330, 744, 308, 602, 555, 549,
    554, 639, 272, 654, 510, 466, 362, 544, 603, 402,426, 530, 632, 502, 358, 270, 293, 334, 742, 316,
    441, 616, 434, 222, 257, 374, 539, 611, 363, 440,415, 452, 282, 537, 370, 315, 659, 246, 629, 290,
    658, 634, 235, 412, 605, 615, 704, 456, 648, 636,348, 422, 613, 289, 625, 620, 702, 635, 730, 204,
    710, 528, 302, 288, 623, 312, 230, 614, 706, 354,450, 414, 260, 633, 206, 432, 505, 542, 608, 548,
    240, 405, 219, 297, 232, 425, 604, 748, 268, 547,750, 649, 651, 213, 276, 646, 536, 624, 428, 438,
    638, 708, 410, 514, 242, 543, 314, 368, 454, 250,
    356, 746, 643, 738, 262
]
    
weight_for_others = 15 / (len(codigos) - 1 if 214 in codigos else len(codigos))
weights_mcc = [85 if code == 214 else weight_for_others for code in codigos]

def generate_clients(n=100):
    clients = []
    titular_data_samples = []  # Almacen de titulares para su reutilización

    for i in range(n):
        msisdn = f"+3465148{i+1200:04}"
        imsi = f"214071234567{800 + i}"
        # mcc = random.randint(200, 799)
        mcc = random.choices(codigos, weights_mcc, k=1)[0]
        # mnc = str(random.randint(0, 999)).zfill(random.choice([2, 3]))
        # cell_id = random.randint(1, 9999)
        if mcc == 214:
            mnc = "07"

        else:
            mnc = str(random.randint(0, 999)).zfill(random.choice([2, 3]))

        cell_id = random.randint(1, 9999)
        titular = i < 75  # Los primeros 75 serán titulares

        if titular:
            # given_name = random.choice(given_names)
            given_name, gender = random.choice(list(given_names.items()))
            family_name = random.choice(family_names)
            name = f"{given_name} {family_name}"
            id_document = f"08359{random.randint(100, 999)}{chr(random.randint(65, 90))}"
            email = strip_accents(f"{name.replace(' ', '').lower()}@gmail.com")  # Corrección para quitar acentos
            # gender = random.choice(["Masculino", "Femenino"])
            birthdate = f"{random.randint(1924, 2006)}-{random.randint(1, 12):02d}-{random.randint(1, 30):02d}"
            street_name = random.choice(street_names)
            street_number = str(random.randint(1, 200))
            postal_code = f"280{random.randint(10, 99)}"
            region = "Madrid"
            locality = "Madrid"
            country = "España"
            house_number_extension = f"{random.randint(1, 3)}{chr(random.randint(65, 72))}" if random.choices([True, False], weights=[80, 20], k=1)[0] else ""

            latest_sim_change = generate_latest_sim_change()

            titular_data = {
                "name": name,
                "givenName": given_name,
                "familyName": family_name,
                "idDocument": id_document,
                "email": email,
                "gender": gender,
                "birthdate": birthdate,
                "address": {
                    "streetName": street_name,
                    "streetNumber": street_number,
                    "postalCode": postal_code,
                    "region": region,
                    "locality": locality,
                    "country": country,
                    "houseNumberExtension": house_number_extension
                }
            }
            titular_data_samples.append(titular_data)
        else:
            titular_data = random.choice(titular_data_samples)
            # Reutilizar también latestSimChange para coherencia, pero se podría ajustar si es necesario
            # latest_sim_change = generate_latest_sim_change(titular_data["birthdate"])
            # latest_sim_change = generate_latest_sim_change()

        client = {
            "msisdn": msisdn,
            "imsi": imsi,
            "mcc": mcc,
            "mnc": mnc,
            "cell_id": cell_id,
            "titular": titular,
            "titular_data": titular_data,
            "latestSimChange": latest_sim_change
        }
        clients.append(client)

    return clients

# Generar 100 clientes
clients_data = generate_clients(100)

# Guardar los clientes en un archivo JSON
with open('generated_clients.json', 'w', encoding='utf-8') as file:
    json.dump(clients_data, file, ensure_ascii=False, indent=2)

print("Archivo JSON con 100 clientes generado y guardado correctamente en UTF-8.")