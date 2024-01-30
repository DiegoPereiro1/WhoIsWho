

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
    personaje(Nombre / _),
    not(member(Nombre, T)),
    add([Nombre|T], Tablero), !.

add(T, Tablero):-
	Tablero = T,!.

/*anadir(P, [], [P|[]]).

anadir(P, T, [P|T]) :-
    \+ member(P, T).     % not */

% ------ mostrar tablero en consola (conectar a Python) ------

escribir_tablero([]):-
    nl.

escribir_tablero([Nombre | Resto]):-
    escribirPersonaje(Nombre),
    escribir_tablero(Resto).

escribirPersonaje(Nombre):-
    personaje(Nombre / C), write(Nombre), write(C), nl.

% BBDD para representar personajes y sus características físicas mediante estructuras

personaje(herman / [pelirrojo, calva, nariz_grande, ojos_marrones]).

personaje(maria / [pelo_largo, sombrero, pendientes, castaño, mujer, ojos_marrones, boca_pequeña]).

personaje(claire / [gafas, sombrero, mujer, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(alfred / [pelo_largo, bigote, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]).

% main

% evaluar(Meta):- solucion(20,[3/2,1/1,3/1,1/2,2/1,2/2,1/3,2/3,3/3],Meta,[]).

% funcion test objetivo

test(Nombre / _,  Nombre / _).
test(personaje(P), personaje(P)).

% Predicados para consultar características de los personajes

tiene(Nombre , Caracteristica) :-
    personaje(Nombre / Caracteristicas),
    member(Caracteristica, Caracteristicas).


/*
 * funcion sucesora
 */

% recorrer tablero eliminando personajes que no tienen esa caracteristica
% supervivientes es el estado

f_sucesora(Caracteristica, Tablero, Supervivientes) :- 
    % levantar_tablero(Tablero),
    bajar(Caracteristica, Tablero, Supervivientes).

bajar(_ , [], []).

bajar(Caracteristica, [Nombre|Resto], [Nombre| Up]) :-
    tiene(Nombre , Caracteristica),
    bajar(Caracteristica, Resto, Up).

% proporcionar en el backtraking una salida true al predicado 
% cuando el personaje no tiene la caracteristica
bajar(Caracteristica, [Nombre|Resto], Up) :-
    not(tiene(Nombre , Caracteristica)),
    bajar(Caracteristica, Resto, Up).

/*
 * busqueda avara
 */

% contar cuantos personajes sobreviven a una caracteristica
% y seleccionar el o las menores.

% necesito una lista con las caracteristicas? pues formarla desde caract
% de la bbdd como levantar_tablero

% ir tirando personajes del tablero
% usar levantar_tablero() para formarlo == estado inicial
% y aplicar funcion sucesora para pasar de un estado a otro
% hasta dejar solo uno == estado objetivo



add_not([] , L, L).

add_not([X|Tail], L, Resultado) :-
    not(member(X , L)),
    add_not(Tail, [X|L], Resultado).

add_not([X|Tail], L, L) :-
    member(X , L),
    add_not(Tail, L, L).


% play game

play(Goal) :- 
% falta seleccionar personaje por nombre y sus caracteristicas
    levantar_tablero(Tablero),
    /* escribir_tablero(Tablero),
    read(C),
    f_sucesora(C, Tablero, Supervivientes),
    escribir_tablero(Supervivientes).*/
    interactivo(Goal, Tablero).

    % ?- length(List,4), test(personaje(Goal), [P|[]]).

interactivo(Goal, Tablero) :-
    escribir_tablero(Tablero),
    personaje(Goal / Caracteristicas),
    read(C),
    member(C, Caracteristicas), % false si escribes una caract que no tiene Goal.
    f_sucesora(C, Tablero, Supervivientes),
    ( length(Supervivientes, 1) -> 
    nombre(Supervivientes, Nombre), test(personaje(Goal), personaje(Nombre)); 
    interactivo(Goal, Supervivientes)).


% pasarle el tablero /supervivientes
nombre([Nombre|_], Nombre).

% seleccionar caract personaje goal

caracteristicas(Goal, C) :-
    personaje(Goal / C).


% main
% paso yo el personaje objetivo.

/*
play(Goal) :- 
    personaje(Goal / C),
    levantar_tablero(Tablero), % tablero estado inicial
    ia(Goal, C).

is(Goal, C, Tablero) :-
    seleccionar_caracteristica_del_cjto_de_caracteristicas_que_tenga_menos_supervivientes,
    f_sucesora(C, Tablero, Supervivientes), % con la caract seleccionada
     ( length(Supervivientes, 1) -> 
    nombre(Supervivientes, Nombre), test(personaje(Goal), personaje(Nombre)); 
    is(Goal, C, Supervivientes)).
*/

% necesito coleccionar todas las características


