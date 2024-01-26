

### Consola swipl

`tab` para backtracking en la consulta
`enter` para pararla tras primer objetivo alcanzado
`halt` para salir del intérprete.

### Consultas


```prolog
?- personaje(tom /_).
false.
```

```Prolog
?- personaje(X /_).
X = herman ;
X = maria ;
X = claire ;
X = alfred ;
X = charles.
```

```prolog
?- escribir([charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], 
            claire / [gafas, sombrero, mujer, pelirrojo, ojos_marrones, boca_pequeña]]).

charles/[bigote,rubio,ojos_marrones,labios_gruesos,boca_grande]
claire/[gafas,sombrero,mujer,pelirrojo,ojos_marrones,boca_pequeña]
```

?- anadir(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], [], T). 
T = [charles/[bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]].

?- member(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], [charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]]).
true.

?- anadir(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], [claire / [gafas, sombrero, mujer, pelirrojo, ojos_marrones]], T).
T = [charles/[bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], claire/[gafas, sombrero, mujer, pelirrojo, ojos_marrones]].

?- anadir(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], [charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]], T).
false.

?- tiene(maria, sombrero).
true ;
false.

?- tiene(maria, sombrero).
true.

?- test(charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande], charles / [bigote, rubio, ojos_marrones, labios_gruesos, boca_grande]).
true.

?- test(personaje(maria / _), personaje(maria / _)).
true.

## Debugger

https://www.swi-prolog.org/pldoc/man?section=debugoverview

## Operadores

#### comentarios

% single line
/* */ multiline

#### not

https://www.swi-prolog.org/pldoc/man?predicate=not/1

Usar esta sintaxis:
 \+ member(P, T).

## Prolog online

https://swish.swi-prolog.org/p/ListOfPersons.pl 