"""
Tests para la aplicación DevOps
Actividad 4.2 - Pruebas de las nuevas funcionalidades
"""

import app


def test_saludar():
    """Test de la función saludar"""
    resultado = app.saludar("Ana")
    assert "Ana" in resultado
    assert "DevOps" in resultado
    print("✓ Test saludar: PASADO")


def test_saludar_errores():
    """Test de validación de errores en saludar"""
    # Test con nombre vacío
    try:
        app.saludar("")
        assert False, "Debería lanzar ValueError"
    except ValueError as e:
        assert "vacío" in str(e).lower()
        print("✓ Test saludar (nombre vacío): PASADO")
    
    # Test con None
    try:
        app.saludar(None)
        assert False, "Debería lanzar ValueError"
    except ValueError:
        print("✓ Test saludar (None): PASADO")
    
    # Test con tipo incorrecto
    try:
        app.saludar(123)
        assert False, "Debería lanzar ValueError"
    except ValueError:
        print("✓ Test saludar (tipo incorrecto): PASADO")


def test_despedir():
    """Test de la función despedir"""
    resultado = app.despedir("Carlos")
    assert "Carlos" in resultado
    assert "DevOps" in resultado
    print("✓ Test despedir: PASADO")


def test_calcular_progreso():
    """Test de la función calcular_progreso"""
    # Test caso normal
    assert app.calcular_progreso(5, 10) == 50.0
    assert app.calcular_progreso(7, 10) == 70.0
    assert app.calcular_progreso(10, 10) == 100.0
    
    # Test caso borde
    assert app.calcular_progreso(0, 10) == 0.0
    assert app.calcular_progreso(0, 0) == 0.0
    
    print("✓ Test calcular_progreso: PASADO")


def test_calcular_progreso_errores():
    """Test de validación de errores en calcular_progreso"""
    # Test con valores negativos
    try:
        app.calcular_progreso(-1, 10)
        assert False, "Debería lanzar ValueError"
    except ValueError as e:
        assert "negativo" in str(e).lower()
        print("✓ Test calcular_progreso (negativo): PASADO")
    
    # Test con completadas > totales
    try:
        app.calcular_progreso(15, 10)
        assert False, "Debería lanzar ValueError"
    except ValueError as e:
        assert "mayor" in str(e).lower()
        print("✓ Test calcular_progreso (mayor): PASADO")
    
    # Test con tipos incorrectos
    try:
        app.calcular_progreso("5", 10)
        assert False, "Debería lanzar TypeError"
    except TypeError:
        print("✓ Test calcular_progreso (tipo incorrecto): PASADO")


def run_all_tests():
    """Ejecuta todos los tests"""
    print("=== Ejecutando Tests ===\n")
    test_saludar()
    test_saludar_errores()
    test_despedir()
    test_calcular_progreso()
    test_calcular_progreso_errores()
    print("\n✅ Todos los tests pasaron correctamente")


if __name__ == "__main__":
    run_all_tests()
