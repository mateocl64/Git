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
        
    Raises:
        ValueError: Si el nombre está vacío o no es válido
    """
    if not nombre or not isinstance(nombre, str):
        raise ValueError("El nombre debe ser una cadena de texto no vacía")
    
    if nombre.strip() == "":
        raise ValueError("El nombre no puede estar vacío")
    
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


def despedir(nombre):
    """
    Función que retorna un mensaje de despedida
    
    Args:
        nombre (str): Nombre de la persona a despedir
    
    Returns:
        str: Mensaje de despedida
    """
    return f"¡Hasta luego, {nombre}! Sigue aprendiendo DevOps"


def calcular_progreso(tareas_completadas, tareas_totales):
    """
    Calcula el porcentaje de progreso en las tareas
    
    Args:
        tareas_completadas (int): Número de tareas completadas
        tareas_totales (int): Número total de tareas
    
    Returns:
        float: Porcentaje de progreso
        
    Raises:
        ValueError: Si los valores no son válidos
        TypeError: Si los argumentos no son números
    """
    # Validar tipos
    if not isinstance(tareas_completadas, (int, float)):
        raise TypeError("tareas_completadas debe ser un número")
    
    if not isinstance(tareas_totales, (int, float)):
        raise TypeError("tareas_totales debe ser un número")
    
    # Validar valores
    if tareas_completadas < 0:
        raise ValueError("tareas_completadas no puede ser negativo")
    
    if tareas_totales < 0:
        raise ValueError("tareas_totales no puede ser negativo")
    
    if tareas_completadas > tareas_totales:
        raise ValueError("tareas_completadas no puede ser mayor que tareas_totales")
    
    if tareas_totales == 0:
        return 0.0
    
    return (tareas_completadas / tareas_totales) * 100


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
    
    # Nueva funcionalidad: cálculo de progreso
    tareas_completadas = 7
    tareas_totales = 10
    progreso = calcular_progreso(tareas_completadas, tareas_totales)
    print(f"\n📊 Progreso del proyecto: {progreso:.1f}%")
    
    # Mostrar estadísticas
    stats = obtener_estadisticas()
    print("\n📊 Estadísticas del Proyecto:")
    print(f"   • Commits: {stats['commits']}")
    print(f"   • Ramas: {stats['ramas']}")
    print(f"   • Archivos: {stats['archivos']}")
    print(f"   • Colaboradores: {stats['colaboradores']}")
    
    # Mensaje de despedida
    despedida = despedir("Estudiante")
    print(f"\n{despedida}")


if __name__ == "__main__":
    main()
