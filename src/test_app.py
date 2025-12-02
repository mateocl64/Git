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


def run_all_tests():
    """Ejecuta todos los tests"""
    print("=== Ejecutando Tests ===\n")
    test_saludar()
    test_despedir()
    test_calcular_progreso()
    print("\n✅ Todos los tests pasaron correctamente")


if __name__ == "__main__":
    run_all_tests()
