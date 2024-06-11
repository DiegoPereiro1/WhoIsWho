from pyswip import Prolog

# Esta función carga la base de datos Prolog desde un archivo y devuelve el objeto Prolog.
def cargar_base_datos():
    prolog = Prolog()
    prolog.consult("/home/diego/WhoIsWho/src/BaseDeDatos.pl")  # Consultar el archivo Prolog que contiene la base de datos de personajes.
    return prolog

# Esta función obtiene todos los personajes y sus características de la base de datos Prolog.
def obtener_personajes(prolog):
    personajes = list(prolog.query("personaje(X, Y)"))  # Realiza una consulta para obtener todos los personajes y sus características.
    return personajes

# Esta función hace una pregunta a la base de datos Prolog basada en una característica específica.
def hacer_pregunta(prolog, caracteristica):
    query = f"personaje(X, Y), member({caracteristica}, Y)"  # Crea una consulta para buscar personajes con la característica dada.
    resultado = list(prolog.query(query))  # Ejecuta la consulta y obtiene los resultados.
    return resultado

# Función principal del script.
def main():
    prolog = cargar_base_datos()  # Carga la base de datos Prolog.

    print("Todos los personajes:")  # Imprime todos los personajes y sus características.
    personajes = obtener_personajes(prolog)
    for p in personajes:
        print(p)

    while True:
        caracteristica = input("Introduce una característica para filtrar (o 'salir' para terminar): ").strip().lower()  # Pide al usuario que introduzca una característica.
        if caracteristica == "salir":
            break  # Si el usuario introduce 'salir', el bucle se rompe y el programa termina.
        resultado = hacer_pregunta(prolog, caracteristica)  # Realiza la consulta con la característica proporcionada.
        print(f"Personajes con la característica '{caracteristica}':")  # Imprime los personajes que tienen la característica dada.
        for res in resultado:
            print(res)

if __name__ == "__main__":
    main()