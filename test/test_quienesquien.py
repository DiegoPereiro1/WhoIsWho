import pytest
from pyswip import Prolog

prolog = Prolog()
prolog.consult('src/quienesquien.pl')

@pytest.mark.levantar
def test_levantar_tablero():
    query = list(prolog.query("levantar_tablero(Tablero)"))
    # devuelve una lista de diccionarios,
    # clave variable, valor propuestas de prolog
    # print(pregunta)
    '''
    [{'Tablero': ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 'anita', 
    'bill', 'bernard', 'alfred', 'frans', 'george', 'david', 'paul', 'joe', 
    'philip', 'peter', 'alex', 'eric', 'richard', 'charles', 'claire', 'maria', 
    'herman']}]
    '''
    tablero = query[0]['Tablero']
    assert tablero == ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 
                        'anita', 'bill', 'bernard', 'alfred', 'frans', 
                        'george', 'david', 'paul', 'joe', 'philip', 
                        'peter', 'alex', 'eric', 'richard', 'charles', 
                        'claire', 'maria', 'herman']

@pytest.mark.bbdd
def test_personaje():
    query = list(prolog.query("personaje(tom /_)"))
    respuesta = query[0]
    assert not respuesta
