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
    """
    if tareas_totales == 0:
        return 0
    return (tareas_completadas / tareas_totales) * 100


def main():
    """Función principal de la aplicación"""
    print("=== Mi Primera Aplicación DevOps ===")
    mensaje = saludar("Estudiante")
    print(mensaje)
    print("\n✓ Repositorio configurado correctamente")
    print("✓ Control de versiones activo")
    
    # Nueva funcionalidad: cálculo de progreso
    tareas_completadas = 7
    tareas_totales = 10
    progreso = calcular_progreso(tareas_completadas, tareas_totales)
    print(f"\n📊 Progreso del proyecto: {progreso:.1f}%")
    
    # Mensaje de despedida
    despedida = despedir("Estudiante")
    print(f"\n{despedida}")


if __name__ == "__main__":
    main()
