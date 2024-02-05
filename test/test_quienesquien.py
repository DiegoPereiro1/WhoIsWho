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
    isPersonaje = list(prolog.query("personaje(tom)."))
    assert not isPersonaje

@pytest.mark.bbdd
def test_personajes():
    '''
    ?- personaje(P /_).
    P = herman ;
    P = maria ;
    P = claire ;
    P = alfred ;
    P = charles.
    '''
    query = list(prolog.query("personaje(P / _)."))
    personajes = [respuesta['P'] for respuesta in query]
    assert personajes == ['herman', 'maria', 'claire', 'charles', 
                          'richard', 'eric', 'alex', 'peter', 
                          'philip', 'joe', 'paul', 'david', 
                          'george', 'frans', 'alfred', 'bernard', 
                          'bill', 'anita', 'robert', 'anne', 
                          'sam', 'tom', 'susan', 'max']

@pytest.mark.tiene
def test_tiene():
    '''
    ?- tiene(maria, sombrero).
    true ;
    '''
    tiene = bool(list(prolog.query("tiene(maria, sombrero).")))
    assert tiene

@pytest.mark.tiene
def test_tiene_c_instancias():
    '''
    ?- tiene(maria, C)
    [{'C': 'mujer'}, {'C': 'pelo_largo'}, {'C': 'sombrero'}, {'C': 'pendientes'}, 
    {'C': 'pelo_castaño'}, {'C': 'ojos_marrones'}, {'C': 'boca_pequeña'}, 
    {'C': 'cejas_finas'}, {'C': 'nariz_pequeña'}]
    '''
    query = list(prolog.query("tiene(maria, C)."))
    caracteristicas = [respuesta['C'] for respuesta in query]
    assert caracteristicas == ['mujer', 'pelo_largo', 'sombrero',
                               'pendientes', 'pelo_castaño', 'ojos_marrones', 
                               'boca_pequeña', 'cejas_finas', 'nariz_pequeña']

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

@pytest.mark.objetivo
def test_es_objetivo():
    '''
    ? - test([maria], maria).
    maria Acertaste!
    true .
    '''
    isGoal = list(prolog.query("test([maria], maria)"))
    assert isGoal

@pytest.mark.objetivo
def test_no_es_objetivo():
    '''
    ? - test([herman], maria).
    Loose!
    false.
    '''
    isGoal = list(prolog.query("test([herman], maria)."))
    assert not isGoal

@pytest.mark.f_sucesora
@pytest.mark.bajar
def test_bajar_personaje():
    '''
    Salvar a los personajes con la caracteristica por la que preguntas.
    ?- bajar(sombrero, [maria, claire, herman], Supervivientes).                               
    Supervivientes = [maria, claire] ;
    '''
    query = list(prolog.query("bajar(sombrero, [maria, claire, herman], S)."))
    supervivientes = query[0]['S']
    assert supervivientes == ['maria', 'claire']

@pytest.mark.f_sucesora
@pytest.mark.bajar
def test_bajar_personajes_sin_caracteristica():
    '''
    ?- bajar(bigote, [maria, claire, herman], Supervivientes).
    Supervivientes = [] ;
    '''
    query = list(prolog.query("bajar(bigote, [maria, claire, herman], S)."))
    supervivientes = query[0]['S']
    assert supervivientes == []

@pytest.mark.f_sucesora
@pytest.mark.bajar
def test_salvar_personajes_con_caracteristica():
    '''
    ?- bajar(sombrero, [maria, claire, eric], Supervivientes).
    Supervivientes = [maria, claire, eric] ;
    '''
    query = list(prolog.query("bajar(sombrero, [maria, claire, eric], S)."))
    supervivientes = query[0]['S']
    assert supervivientes == ['maria', 'claire', 'eric']

@pytest.mark.f_sucesora
@pytest.mark.bajar_not
def test_salvar_personajes_sin_caracteristica():
    '''
    ?- bajar_not(bigote, [maria, claire, herman], Supervivientes).
    Supervivientes = [maria, claire, herman] .
    '''
    query = list(prolog.query("bajar_not(bigote, [maria, claire, herman], S)."))
    supervivientes = query[0]['S']
    assert supervivientes == ['maria', 'claire', 'herman']

@pytest.mark.f_sucesora
@pytest.mark.bajar_not
def test_bajar_personajes_con_caracteristica():
    '''
    ?- bajar_not(sombrero, [maria, claire, eric], Supervivientes).
    Supervivientes = [maria, claire, herman] .
    '''
    query = list(prolog.query("bajar_not(sombrero, [maria, claire, eric], S)."))
    supervivientes = query[0]['S']
    assert supervivientes == []
