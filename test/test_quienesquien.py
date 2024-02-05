import pytest
from pyswip import Prolog

prolog = Prolog()
prolog.consult('src/quienesquien.pl')

@pytest.mark.levantar
def test_levantar_tablero():
    pregunta = list(prolog.query("levantar_tablero(Tablero)"))
    # devuelve una lista de diccionarios,
    # clave variable, valor propuestas de prolog
    print(pregunta)
    '''
    [{'Tablero': ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 'anita', 
    'bill', 'bernard', 'alfred', 'frans', 'george', 'david', 'paul', 'joe', 
    'philip', 'peter', 'alex', 'eric', 'richard', 'charles', 'claire', 'maria', 
    'herman']}]
    '''
    tablero = pregunta[0]['Tablero']
    assert  tablero == ['max', 'susan', 'tom', 'sam', 'anne', 'robert', 
                        'anita', 'bill', 'bernard', 'alfred', 'frans', 
                        'george', 'david', 'paul', 'joe', 'philip', 
                        'peter', 'alex', 'eric', 'richard', 'charles', 
                        'claire', 'maria', 'herman']
