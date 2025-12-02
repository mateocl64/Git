"""
Aplicación de ejemplo para el proyecto DevOps
Actividad 4.1 - Mi primer repositorio
"""

def saludar(nombre):
    """
    Función que retorna un saludo personalizado mejorado
    
    Args:
        nombre (str): Nombre de la persona a saludar
    
    Returns:
        str: Mensaje de saludo personalizado con emoji
    """
    return f"👋 ¡Hola, {nombre}! Bienvenido al increíble mundo DevOps 🚀"


def obtener_estadisticas():
    """
    Obtiene las estadísticas del proyecto DevOps
    
    Returns:
        dict: Diccionario con estadísticas del proyecto
    """
    return {
        "commits": 13,
        "ramas": 3,
        "archivos": 12,
        "colaboradores": 1
    }


def main():
    """Función principal de la aplicación mejorada"""
    print("╔══════════════════════════════════════════╗")
    print("║  Mi Primera Aplicación DevOps - v2.0    ║")
    print("╚══════════════════════════════════════════╝\n")
    
    mensaje = saludar("Estudiante")
    print(mensaje)
    
    print("\n✅ Repositorio configurado correctamente")
    print("✅ Control de versiones activo")
    print("✅ Trabajo con ramas implementado")
    
    # Mostrar estadísticas
    stats = obtener_estadisticas()
    print("\n📊 Estadísticas del Proyecto:")
    print(f"   • Commits: {stats['commits']}")
    print(f"   • Ramas: {stats['ramas']}")
    print(f"   • Archivos: {stats['archivos']}")
    print(f"   • Colaboradores: {stats['colaboradores']}")


if __name__ == "__main__":
    main()
