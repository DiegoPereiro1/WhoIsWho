import pytest
from pyswip import Prolog

prolog = Prolog()
prolog.consult('src/quienesquien.pl')

@pytest.mark.levantar
def test_levantar_tablero():
    '''
    ?- levantar_tablero(Tablero).
    Tablero = [max, susan, tom, sam, anne, robert, anita, bill, bernard|...].
    '''
    query = list(prolog.query("levantar_tablero(Tablero)."))
    # devuelve una lista de diccionarios,
    # clave variable, valor propuestas de prolog
    # print(pregunta)
    #
    # [{'Tablero': ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 'anita', 
    # bill', 'bernard', 'alfred', 'frans', 'george', 'david', 'paul', 'joe', 
    # philip', 'peter', 'alex', 'eric', 'richard', 'charles', 'claire', 'maria', 
    # herman']}]

    tablero = query[0]['Tablero']
    assert tablero == ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 
                        'anita', 'bill', 'bernard', 'alfred', 'frans', 
                        'george', 'david', 'paul', 'joe', 'philip', 
                        'peter', 'alex', 'eric', 'richard', 'charles', 
                        'claire', 'maria', 'herman']

@pytest.mark.bbdd
def test_personaje():
    '''
    ?- personaje(tom /_).
    false.
    '''
    query = list(prolog.query("personaje(tom)."))
    assert not query

@pytest.mark.tiene
def test_tiene():
    '''
    ?- tiene(maria, sombrero).
    true ;
    '''
    query = bool(list(prolog.query("tiene(maria, sombrero).")))
    assert query

@pytest.mark.caracteristicas
def test_caracteristicas_personaje():
    '''
    ?- caracteristicas(maria, C).
    C = [mujer, pelo_largo, sombrero, pendientes, 
        pelo_castaño, ojos_marrones, boca_pequeña, 
        cejas_finas, nariz_pequeña].
    '''
    query = list(prolog.query("caracteristicas(maria, C)."))
    caracteristicas = query[0]['C']
    assert caracteristicas == ['mujer', 'pelo_largo', 'sombrero', 'pendientes', 
                               'pelo_castaño', 'ojos_marrones', 'boca_pequeña', 
                               'cejas_finas', 'nariz_pequeña']
