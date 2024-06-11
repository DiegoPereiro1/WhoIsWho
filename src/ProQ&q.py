import random
from pyswip import Prolog

# Esta función carga la base de datos Prolog desde un archivo y devuelve el objeto Prolog
def cargar_base_datos():
    prolog = Prolog()
    prolog.consult("/home/diego/WhoIsWho/src/BaseDeDatos.pl")  # Consultar el archivo Prolog que contiene la base de datos de personajes
    return prolog

# Esta función obtiene todos los personajes y sus características de la base de datos Prolog
def obtener_personajes(prolog):
    personajes = []
    for result in prolog.query("personaje(X, Y)"):
        nombre = str(result["X"])
        caracteristicas = [str(caracteristica) for caracteristica in result["Y"]]
        personajes.append({"nombre": nombre, "caracteristicas": caracteristicas})
    return personajes

# Esta función hace una pregunta a la base de datos Prolog basada en una característica específica.
def hacer_pregunta(prolog, caracteristica):
    query = f"personaje(X, Y), member({caracteristica}, Y)"  
    resultado = list(prolog.query(query))  # Ejecuta la consulta y obtiene los resultados.
    return [{"nombre": str(res["X"]), "caracteristicas": [str(car) for car in res["Y"]]} for res in resultado]

# Función principal
def main():
    prolog = cargar_base_datos()  # Carga la base de datos Prolog.
    
    # Selecciona un personaje aleatorio
    personajes = obtener_personajes(prolog)
    personaje_seleccionado = random.choice(personajes)
    print("He elegido un personaje. ¡Intenta adivinar quién es!")

    # Mostrar todos los personajes al inicio
    print("Todos los personajes:")
    for p in personajes:
        print(f"Nombre: {p['nombre']}, Características: {p['caracteristicas']}")

    while True:
        entrada = input("Introduce una característica o intenta adivinar el nombre (o 'salir' para terminar): ").strip().lower()  # Pide al usuario que introduzca una característica o nombre.
        if entrada == "salir":
            break  

        # Verificar si el usuario ha adivinado el nombre del personaje
        if entrada == personaje_seleccionado['nombre'].lower():
            print(f"¡Has acertado! El personaje es: {personaje_seleccionado['nombre']}.")
            break
        
       
        if entrada in [car.lower() for car in personaje_seleccionado['caracteristicas']]:
            print(f"El personaje seleccionado tiene la característica '{entrada}'.")
            
            # Filtrar personajes que no tienen la característica
            personajes = [p for p in personajes if entrada in [car.lower() for car in p['caracteristicas']]]

            
            if personajes:
                print(f"Personajes con la característica '{entrada}':")
                for p in personajes:
                    print(f"Nombre: {p['nombre']}, Características: {p['caracteristicas']}")
            else:
                print("No quedan personajes con las características dadas.")
                break

            # Verificar si solo queda un personaje posible
            if len(personajes) == 1:
                print(f"¡Has acertado!  {personajes[0]['nombre']} es el personaje.")
                break
        else:
            print(f"El personaje seleccionado no tiene la característica '{entrada}'.")

if __name__ == "__main__":
    main()