

% funcion sucesor

/*
 * construir tablero = conjunto de personajes, lista de listas
 */

/*levantar_tablero(Tablero) :-
    personaje(P), 
    anadir(P, Tablero, Tablero_up),
    escribir(Tablero_up),
    levantar_tablero(Tablero_up).*/

% levantar_tablero(Tablero) :- findall(P, personaje(P), Tablero).

levantar_tablero(Tablero) :-
    add([], Tablero).

add(T, Tablero) :-
    personaje(P),
    not(member(P, T)),
    add([P|T], Tablero), !.

add(T, Tablero):-
	Tablero = T,!,
    escribir(Tablero).

/*anadir(P, [], [P|[]]).

anadir(P, T, [P|T]) :-
    \+ member(P, T).     % not */

% ------ mostrar tablero en consola (conectar a Python) ------

escribir([]):-
    nl.

escribir([Personaje | Resto]):-
    escribirPersonaje(Personaje),
    escribir(Resto).

escribirPersonaje(Nombre / Caracteristicas):-
    write(Nombre / Caracteristicas), nl.

% busqueda avara



% BBDD para representar personajes y sus características físicas mediante estructuras

personaje(herman / [pelirrojo, calva, nariz_grande, ojos_marrones]).

personaje(maria / [pelo_largo, sombrero, pendientes, castaño, mujer, ojos_marrones, boca_pequeña]).

personaje(claire / [gafas, sombrero, mujer, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(alfred / [pelo_largo, bigote, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]).

% main

evaluar(Meta):- solucion(20,[3/2,1/1,3/1,1/2,2/1,2/2,1/3,2/3,3/3],Meta,[]).

% funcion test objetivo

test(Nombre / _,  Nombre / _).
test(personaje(P), personaje(P)).

% Predicados para consultar características de los personajes

tiene(Nombre, Caracteristica) :-

    personaje(Nombre / Caracteristicas),

    member(Caracteristica, Caracteristicas).

% Ejemplos de consultas

% ¿Juan lleva gafas?

% ?- tiene(juan, gafas).

% Respuesta: true

