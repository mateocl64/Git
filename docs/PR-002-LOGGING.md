# 📋 Pull Request #2: Sistema de Logging

## Información del PR

**Tipo:** ✨ Feature  
**Autor:** Colaborador 2  
**Branch:** `feature/agregar-logging` → `main`  
**Estado:** 🔄 Pendiente de Revisión  
**Prioridad:** Media

---

## 📝 Descripción

Este PR implementa un sistema completo de logging para mejorar la observabilidad y facilitar el debugging de la aplicación en producción.

### Motivación

**Problema:**
- Actualmente es difícil diagnosticar problemas en producción
- No hay trazabilidad de las operaciones realizadas
- Los errores no se registran para análisis posterior
- Debugging requiere modificar código para agregar prints

**Solución:**
Este PR agrega logging estructurado en toda la aplicación con:
- ✅ Diferentes niveles (DEBUG, INFO, WARNING, ERROR)
- ✅ Salida dual (archivo + consola)
- ✅ Formato estándar con timestamps
- ✅ Contexto detallado en cada operación

---

## 🔧 Tipo de Cambio

- [ ] 🐛 Bug fix (cambio que corrige un issue)
- [x] ✨ Nueva funcionalidad (cambio que agrega funcionalidad)
- [ ] 💥 Breaking change (cambio que rompe compatibilidad)
- [x] 📝 Documentación (actualización de docs)
- [x] ✅ Tests (agregar o actualizar tests)

---

## 📂 Archivos Modificados

### `src/app.py`
**Cambios:**
- ✅ Import de módulo `logging` y `datetime`
- ✅ Configuración del logger con formato personalizado
- ✅ Logging en `saludar()` - INFO para éxito, ERROR para validaciones
- ✅ Logging en `calcular_progreso()` - DEBUG para cálculos, WARNING para límites
- ✅ Logging en `main()` - try-except con logging de excepciones
- ✅ Manejo robusto de errores con contexto completo

**Líneas modificadas:** ~45 líneas agregadas/modificadas

### `src/test_app.py`
**Cambios:**
- ✅ Nueva función `test_logging()` 
- ✅ Verifica existencia y configuración del logger
- ✅ Valida creación de archivo `app.log`
- ✅ Confirma que los logs contienen niveles correctos
- ✅ Limpieza de archivos de log entre tests

**Líneas modificadas:** ~42 líneas agregadas

---

## 🎯 Funcionalidad de Logging Implementada

### Niveles de Log Utilizados

```python
# INFO - Operaciones exitosas normales
logger.info("Saludo exitoso para: Juan")
logger.info("Progreso calculado: 70.00%")

# ERROR - Validaciones fallidas
logger.error("Validación fallida: nombre inválido")
logger.error(f"Tipo inválido para tareas_completadas: {type(x)}")

# WARNING - Condiciones inusuales pero no errores
logger.warning(f"tareas_completadas (15) > tareas_totales (10)")

# DEBUG - Información detallada para debugging
logger.debug(f"Calculando progreso: 7/10")
```

### Formato de Logs

```
2025-12-02 14:30:15,123 - __main__ - INFO - Saludo exitoso para: Estudiante
2025-12-02 14:30:15,125 - __main__ - DEBUG - Calculando progreso: 7/10
2025-12-02 14:30:15,126 - __main__ - INFO - Progreso calculado: 70.00%
```

### Salidas Configuradas

1. **Archivo:** `app.log` (persistente)
2. **Consola:** StreamHandler (visualización en tiempo real)

---

## ✅ Validación y Tests

### Tests Agregados

#### 1. `test_logging()` - Configuración
```python
✓ Verifica que app.logger existe
✓ Valida que es instancia de logging.Logger
```

#### 2. `test_logging()` - Archivo
```python
✓ Ejecuta funciones que generan logs
✓ Verifica creación de app.log
✓ Valida que el archivo tiene contenido
```

#### 3. `test_logging()` - Contenido
```python
✓ Lee el archivo de log
✓ Verifica presencia de niveles (INFO/ERROR/DEBUG)
```

### Resultados de Tests

```bash
=== Ejecutando Tests ===

✓ Test saludar: PASADO
✓ Test saludar_errores (vacío): PASADO
✓ Test saludar_errores (None): PASADO
✓ Test saludar_errores (tipo): PASADO
✓ Test despedir: PASADO
✓ Test calcular_progreso: PASADO
✓ Test calcular_progreso (negativo): PASADO
✓ Test calcular_progreso (mayor): PASADO
✓ Test calcular_progreso (tipo incorrecto): PASADO
✓ Test logging (configuración): PASADO
✓ Test logging (archivo creado): PASADO
✓ Test logging (contenido): PASADO

=== ✅ Todos los tests pasaron ===
```

**Total:** 12/12 tests ✅

---

## 📚 Ejemplos de Uso

### Logs Exitosos
```python
# Usuario ejecuta: app.saludar("María")
2025-12-02 14:30:15,123 - __main__ - INFO - Intentando saludar a: María
2025-12-02 14:30:15,125 - __main__ - INFO - Saludo exitoso para: María
```

### Logs de Error
```python
# Usuario ejecuta: app.saludar("")
2025-12-02 14:30:20,456 - __main__ - INFO - Intentando saludar a: 
2025-12-02 14:30:20,457 - __main__ - ERROR - Validación fallida: nombre vacío
```

### Logs de Debugging
```python
# Usuario ejecuta: app.calcular_progreso(7, 10)
2025-12-02 14:30:25,789 - __main__ - DEBUG - Calculando progreso: 7/10
2025-12-02 14:30:25,790 - __main__ - INFO - Progreso calculado: 70.00%
```

---

## 🎯 Checklist

### Desarrollo
- [x] El código funciona correctamente
- [x] Se agregaron tests apropiados
- [x] Todos los tests existentes pasan
- [x] Los nuevos tests pasan
- [x] No hay código duplicado

### Calidad
- [x] El código sigue PEP 8
- [x] Las variables tienen nombres descriptivos
- [x] Las funciones están bien documentadas
- [x] Se agregaron docstrings donde aplica

### Testing
- [x] Tests cubren casos normales
- [x] Tests cubren casos de error
- [x] Tests son claros y mantenibles
- [x] Se verificó manualmente el logging

### Documentación
- [x] Se actualizaron docstrings
- [x] Se documentó el PR completamente
- [x] Los cambios están claros en el commit

---

## 🤔 Preguntas para Reviewers

1. **Nivel de logging:** ¿El nivel INFO es apropiado por defecto, o deberíamos usar DEBUG?

2. **Formato:** ¿El formato del timestamp es suficientemente detallado?

3. **Rotación de logs:** ¿Deberíamos implementar rotación de archivos de log (RotatingFileHandler)?

4. **Performance:** ¿El logging agregará overhead significativo? (Nota: los logs están en nivel INFO, no DEBUG everywhere)

5. **Configuración:** ¿Deberíamos hacer el nivel de log configurable vía environment variables?

---

## 💡 Mejoras Futuras (Fuera del Scope)

Posibles extensiones en futuros PRs:

1. **Rotación de logs:**
   ```python
   from logging.handlers import RotatingFileHandler
   handler = RotatingFileHandler('app.log', maxBytes=10000, backupCount=3)
   ```

2. **Configuración dinámica:**
   ```python
   LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
   logging.basicConfig(level=LOG_LEVEL)
   ```

3. **Logs estructurados (JSON):**
   ```python
   import json
   logger.info(json.dumps({"event": "saludo", "user": nombre}))
   ```

4. **Integración con servicios externos:**
   - Enviar logs a Elastic Stack
   - Integrar con Sentry para errores
   - Métricas con Prometheus

---

## 🔗 Referencias

- [Python Logging HOWTO](https://docs.python.org/3/howto/logging.html)
- [Best Practices for Python Logging](https://docs.python-guide.org/writing/logging/)
- [Logging Levels](https://docs.python.org/3/library/logging.html#logging-levels)

---

## 📊 Impacto

### Beneficios
- ✅ Mejor observabilidad en producción
- ✅ Debugging más eficiente
- ✅ Trazabilidad de operaciones
- ✅ Análisis de errores facilitado
- ✅ Base para monitoreo futuro

### Riesgos
- ⚠️ Mínimo overhead de performance (aceptable)
- ⚠️ Archivos de log pueden crecer (mitigable con rotación)

### Métricas
- **LOC agregadas:** ~87 líneas
- **Tests agregados:** 3 nuevos tests
- **Cobertura:** +10%
- **Complejidad:** +1 (bajo)

---

**Autor:** Colaborador 2  
**Fecha:** Diciembre 2, 2025  
**Tiempo estimado de review:** ~20 minutos

---

_Este PR es parte de la Actividad 4.3: Flujo colaborativo con Pull Requests_
