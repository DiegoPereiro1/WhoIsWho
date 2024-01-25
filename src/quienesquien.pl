



% Hechos para representar personajes y sus características físicas

personaje(herman, [pelirrojo, calva, nariz_grande, ojos_marrones]).

personaje(maria, [pelo_largo, sombrero, pendientes, castaño, mujer, ojos_marrones, boca_pequeña]).

personaje(claire, [gafas, sombrero, mujer, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(alfred, [pelo_largo, bigote, pelirrojo, ojos_marrones, boca_pequeña]).

personaje(charles, [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]).

% Predicados para consultar características de los personajes

tiene_caracteristica(Nombre, Caracteristica) :-

    personaje(Nombre, Caracteristicas),

    member(Caracteristica, Caracteristicas).

% Ejemplos de consultas

% ¿Juan lleva gafas?

% ?- tiene_caracteristica(juan, gafas).

% Respuesta: true

