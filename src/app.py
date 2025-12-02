"""
Aplicación de ejemplo para el proyecto DevOps
Actividad 4.1 - Mi primer repositorio
"""

def saludar(nombre):
    """
    Función que retorna un saludo personalizado
    
    Args:
        nombre (str): Nombre de la persona a saludar
    
    Returns:
        str: Mensaje de saludo
    """
    return f"¡Hola, {nombre}! Bienvenido al mundo DevOps"


def main():
    """Función principal de la aplicación"""
    print("=== Mi Primera Aplicación DevOps ===")
    mensaje = saludar("Estudiante")
    print(mensaje)
    print("\n✓ Repositorio configurado correctamente")
    print("✓ Control de versiones activo")


if __name__ == "__main__":
    main()
