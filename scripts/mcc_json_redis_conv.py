import json

# Cambia este nombre de archivo por el camino a tu archivo JSON de entrada
input_filename = 'mcc-mnc-list.json'
# El archivo de salida que será compatible con la importación en Redis
output_filename = 'mcc_country_redis_import.txt'

def process_data(input_filename, output_filename):
    unique_pairs = set()

    # Cargar y procesar el archivo JSON
    try:
        with open(input_filename, 'r', encoding='utf-8') as file:
            data = json.load(file)

            for entry in data:
                mcc = entry.get('mcc')
                country_name = entry.get('countryName')
                # Asegurarse de que ambos valores no son None antes de aplicar strip
                if mcc is not None and country_name is not None:
                    mcc = mcc.strip()
                    country_name = country_name.strip()
                    # Asegurar que solo agregamos pares únicos y colocar comillas dobles alrededor de los nombres de países
                    unique_pairs.add((mcc, f'"{country_name}"'))
    except Exception as e:
        print(f"Error al procesar el archivo JSON: {e}")
        return

    # Escribir los pares únicos en el archivo de salida
    try:
        with open(output_filename, 'w', encoding='utf-8') as file:
            for mcc, country_name in unique_pairs:
                # Formato para importación en Redis: SET mcc "country_name"
                file.write(f"SET {mcc} {country_name}\n")
        print(f"Archivo '{output_filename}' generado exitosamente.")
    except Exception as e:
        print(f"Error al escribir en el archivo de salida: {e}")

# Ejecutar la función con los archivos de entrada y salida especificados
process_data(input_filename, output_filename)
