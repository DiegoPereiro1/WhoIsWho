

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

personaje(herman / [hombre, pelirrojo, calva, nariz_grande, ojos_marrones, cejas_gruesas]).

personaje(maria / [mujer, pelo_largo, sombrero, pendientes, pelo_castaño, ojos_marrones, boca_pequeña, cejas_finas, nariz_pequeña]).

personaje(claire / [mujer, gafas, sombrero, pelirrojo, ojos_marrones, boca_pequeña, nariz_pequeña]).

personaje(charles / [hombre, bigote, pelo_rubio, ojos_marrones, labios_gruesos, boca_grande, orejas_grandes, raya_al_lado, nariz_pequeña]).

personaje(richard / [hombre, calva, barba, ojos_marrones, orejas_grandes, bigote, cara_alargada, nariz_pequeña]).

personaje(eric / [hombre, pelo_rubio, gorra, sombrero, ojos_marrones, boca_grande, nariz_pequeña]).

personaje(alex / [hombre, bigote, pelo_negro, ojos_marrones, boca_grande, labios_gruesos, orejas_grandes, pelo_corto, nariz_pequeña]).

personaje(peter / [hombre, canas, pelo_blanco, nariz_grande, ojos_azules, cejas_gruesas, labios_gruesos, boca_grande, raya_al_lado]).

personaje(philip / [hombre, barba, pelo_negro, ojos_marrones, orejas_grandes, mofletes, mejillas_sonrosadas, cejas_finas, pelo_corto, nariz_pequeña]).

personaje(joe / [hombre, gafas, pelo_rubio, ojos_marrones, boca_pequeña, pelo_corto, nariz_pequeña]).

personaje(paul / [hombre, gafas, pelo_blanco, canas, ojos_marrones, boca_pequeña, orejas_grandes, cejas_gruesas, raya_al_lado, nariz_pequeña]).

personaje(david / [hombre, barba, pelo_rubio, ojos_marrones, orejas_grandes, raya_al_lado, nariz_pequeña]).

personaje(george / [hombre, cara_triste, sombrero, pelo_blanco, canas, ojos_marrones, boca_grande, nariz_pequeña]).

personaje(frans / [hombre, pelo_corto, cejas_gruesas, pelirrojo, ojos_marrones, boca_pequeña, nariz_pequeña]).

personaje(alfred / [hombre, bigote, barba, pelirrojo, ojos_azules, boca_pequeña, orejas_grandes, pelo_largo, raya_al_medio, nariz_pequeña]).

personaje(bernard / [hombre, pelo_castaño, sombrero, ojos_marrones, boca_pequeña, cejas_finas, nariz_grande]).

personaje(bill / [hombre, barba, pelirrojo, ojos_marrones, orejas_grandes, mofletes, mejillas_sonrosadas, calva, boca_pequeña, nariz_pequeña]).

personaje(anita / [mujer, pelo_largo, pelo_rubio, ojos_marrones, boca_pequeña, mofletes, mejillas_sonrosadas, raya_al_medio, nariz_pequeña]).

personaje(robert / [hombre, cara_triste, pelo_castaño, ojos_azules, orejas_grandes, nariz_grande, raya_al_lado, cara_alargada, mofletes, mejillas_sonrosadas]).

personaje(anne / [mujer, pelo_corto, pendientes, pelo_negro, ojos_marrones, boca_pequeña, nariz_grande]).

personaje(sam / [hombre, gafas, calva, pelo_blanco, canas, ojos_marrones, boca_pequeña, nariz_pequeña]).

personaje(tom / [hombre, gafas, calva, pelo_negro, ojos_azules, boca_pequeña, cara_alargada, nariz_pequeña]).

personaje(susan / [mujer, pelo_largo, pelo_blanco, canas, ojos_marrones, labios_gruesos, mofletes, mejillas_sonrosadas, nariz_pequeña, raya_al_lado]).

personaje(max / [hombre, bigote, pelo_negro, ojos_marrones, boca_grande, labios_gruesos, nariz_grande, orejas_grandes, pelo_corto]).


% main

% evaluar(Meta):- solucion(20,[3/2,1/1,3/1,1/2,2/1,2/2,1/3,2/3,3/3],Meta,[]).

% funcion test objetivo

test([Nombre|_],  Nombre) :-
    write(Nombre), write(' Acertaste!'), !.
test([Nombre| _], Goal) :- 
    Nombre \= Goal,
    % de momento no se alcanza nunca porque la maquina no se equivoca al bajar
    write('Loose!'),
    fail.


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
