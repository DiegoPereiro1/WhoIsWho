

% funcion sucesor

/*
 * construir tablero = conjunto de personajes, lista de listas
 */

% levantar_tablero(Tablero) :- findall(P, personaje(P), Tablero).

levantar_tablero(Tablero) :-
    add([], Tablero).

add(T, Tablero) :-
    personaje(Nombre / _),
    not(member(Nombre, T)),
    add([Nombre|T], Tablero), !.

add(T, Tablero):-
	Tablero = T,!.

% ------ mostrar tablero en consola (conectar a Python) ------

escribir_tablero([]):-
    nl.

escribir_tablero([Nombre | Resto]):-
    escribirPersonaje(Nombre),
    escribir_tablero(Resto).

escribirPersonaje(Nombre):-
    personaje(Nombre / C), write(Nombre), write(C), nl.

% BBDD para representar personajes y sus características físicas mediante estructuras

personaje(herman / [hombre, pelirrojo, calva, nariz_grande, ojos_marrones]).

personaje(maria / [pelo_largo, sombrero, pendientes, castaño, mujer, ojos_marrones, boca_pequeña]).

personaje(claire / [gafas, sombrero, mujer, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(alfred / [hombre, pelo_largo, bigote, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(charles / [hombre, bigote, rubio, ojos_marrones, labios_gruesos, boca_grande, orejas_grandes]).

personaje(richard / [calva, barba, ojos_marrones, orejas_grandes, bigote, hombre]).

% main

% evaluar(Meta):- solucion(20,[3/2,1/1,3/1,1/2,2/1,2/2,1/3,2/3,3/3],Meta,[]).

% funcion test objetivo

test([Nombre|_],  Nombre) :-
    write(Nombre), write(' Acertaste!').
test([Nombre| _], Goal) :- 
    Nombre \= Goal,
    % de momento no se alcanza nunca porque la maquina no se equivoca al bajar
    write('Loose!').


% Predicados para consultar características de los personajes

tiene(Nombre , Caracteristica) :-
    personaje(Nombre / Caracteristicas),
    member(Caracteristica, Caracteristicas).


/*
 * funcion sucesora
 */

% recorrer tablero eliminando personajes que tienen /no tienen esa caracteristica
% supervivientes es el estado
f_sucesora(Caracteristica, Caracteristicas, Tablero, Supervivientes) :- 
    ( member(Caracteristica, Caracteristicas) ->
    bajar(Caracteristica, Tablero, Supervivientes);
    bajar_not(Caracteristica, Tablero, Supervivientes)).


bajar(_ , [], []).

bajar(Caracteristica, [Nombre|Resto], [Nombre| Up]) :-
    tiene(Nombre , Caracteristica),
    bajar(Caracteristica, Resto, Up).

% proporcionar en el backtraking una salida true al predicado 
% cuando el personaje no tiene la caracteristica
bajar(Caracteristica, [Nombre|Resto], Up) :-
    not(tiene(Nombre , Caracteristica)),
    bajar(Caracteristica, Resto, Up).


bajar_not(_ , [], []).

bajar_not(Caracteristica, [Nombre|Resto], [Nombre| Up]) :-
    not(tiene(Nombre , Caracteristica)),
    bajar_not(Caracteristica, Resto, Up).

bajar_not(Caracteristica, [Nombre|Resto], Up) :-
    tiene(Nombre , Caracteristica),
    bajar_not(Caracteristica, Resto, Up).


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


% Crear el listado de todos los posibles rasgos de los personajes del tablero

rasgos([P| Resto], Resultado) :-
    personaje(P / Caracteristicas),
    add_not(Caracteristicas, [] , C),
    resto(Resto, C, Resultado).

resto([P|Resto], C, Todas) :-
    personaje(P / Caracteristicas),
    add_not(Caracteristicas, C , Resultado),
    resto(Resto, Resultado, Todas).

resto([], C, C).


add_not([], L, L).

add_not([X|Tail], L, Resultado) :-
    not(member(X , L)),
    add_not(Tail, [X|L], Resultado).

add_not([X|Tail], L, Resultado) :-
    member(X , L),
    add_not(Tail, L, Resultado).


% play game

play(Goal) :- 
% falta seleccionar personaje por nombre y sus caracteristicas
    personaje(Goal / Caracteristicas),
    levantar_tablero(Tablero),
    rasgos(Tablero, Rasgos),
    escribir_caracteristicas(Rasgos),
    interactivo(Goal, Caracteristicas, Tablero, Rasgos).

interactivo(Goal, Caracteristicas, Tablero, Rasgos) :-
    escribir_tablero(Tablero),
    read(C),
    f_sucesora(C, Caracteristicas, Tablero, Supervivientes),
    ( length(Supervivientes, 1) -> 
    test(Supervivientes, Goal); 
    interactivo(Goal, Caracteristicas, Supervivientes, Rasgos)).

% seleccionar caract personaje goal

caracteristicas(Personaje, C) :-
    personaje(Personaje / C).

escribir_caracteristicas([]) :-
    nl.

escribir_caracteristicas([C|Resto]) :-
    write(C), write(' - '),
    escribir_caracteristicas(Resto).

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


/*
1. Alex
2. Alfred
3. Anita
4. Anne
5. Bernard
6. Bill
7. Charles
8. Claire
9. David
10. Eric
11. Frans
12. George
13. Herman
14. Joe
15. Maria
16. Max
17. Paul
18. Peter
19. Philip
20. Richard
21. Robert
22. Sam
23. Susan
24. Tom

*/