# Pull Request #1: Agregar Validación de Errores

## 📝 Descripción

Este PR agrega validación robusta de entradas a las funciones principales del proyecto, mejorando la confiabilidad y facilitando el debugging.

## 🎯 Tipo de Cambio

- [x] ✨ Nueva característica (feat)
- [ ] 🐛 Corrección de bug (fix)
- [ ] 📚 Documentación (docs)
- [ ] ♻️ Refactorización (refactor)
- [ ] ✅ Tests (test)

## 📋 Cambios Realizados

### Archivos Modificados
1. `src/app.py`
   - Validación en `saludar()`: tipos y valores vacíos
   - Validación en `calcular_progreso()`: tipos, negativos, rangos
   - Documentación mejorada con sección `Raises`

2. `src/test_app.py`
   - Nuevas funciones: `test_saludar_errores()` y `test_calcular_progreso_errores()`
   - Tests para casos de error
   - Cobertura de edge cases

### Funcionalidad Agregada

#### Validación en `saludar(nombre)`
```python
# Ahora valida:
- Tipo de dato (debe ser string)
- Valores None
- Strings vacíos
```

#### Validación en `calcular_progreso(completadas, totales)`
```python
# Ahora valida:
- Tipos de datos (deben ser números)
- Valores negativos
- Rango válido (completadas <= totales)
```

## ✅ Checklist

- [x] El código sigue las convenciones del proyecto
- [x] He realizado una auto-revisión de mi código
- [x] He comentado áreas complejas del código
- [x] He actualizado la documentación
- [x] Mis cambios no generan nuevas advertencias
- [x] He agregado tests que prueban mi solución
- [x] Los tests nuevos y existentes pasan localmente
- [x] El commit tiene un mensaje descriptivo

## 🧪 Tests

### Tests Agregados
- `test_saludar_errores()` - 3 casos de error
- `test_calcular_progreso_errores()` - 3 casos de error

### Resultado de Tests
```
✓ Test saludar: PASADO
✓ Test saludar (nombre vacío): PASADO
✓ Test saludar (None): PASADO
✓ Test saludar (tipo incorrecto): PASADO
✓ Test despedir: PASADO
✓ Test calcular_progreso: PASADO
✓ Test calcular_progreso (negativo): PASADO
✓ Test calcular_progreso (mayor): PASADO
✓ Test calcular_progreso (tipo incorrecto): PASADO
```

## 💡 Motivación

**Problema:** Las funciones actuales no validaban entradas, lo que podría causar errores difíciles de debuggear.

**Solución:** Agregar validaciones tempranas con mensajes de error descriptivos.

**Beneficio:** 
- ✅ Errores más claros para los usuarios
- ✅ Debugging más fácil
- ✅ Código más robusto
- ✅ Mejor experiencia de desarrollo

## 📸 Capturas (si aplica)

N/A - Cambios en lógica interna, sin cambios visuales.

## 🔗 Issues Relacionados

Resuelve: #N/A (mejora proactiva)

## 📚 Documentación Actualizada

- [x] Docstrings actualizados con sección `Raises`
- [x] Tests documentados
- [x] Comentarios en código complejo

## ⚠️ Breaking Changes

**NO** - Los cambios son retrocompatibles. Las funciones aceptan los mismos parámetros válidos que antes.

## 🤔 Preguntas para Revisores

1. ¿Los mensajes de error son suficientemente descriptivos?
2. ¿Hay algún edge case que no esté cubierto?
3. ¿La documentación es clara?

## 👥 Revisores Sugeridos

@mateocl64 - Maintainer principal

---

**Autor:** Colaborador 1  
**Fecha:** Diciembre 2, 2025  
**Rama:** `feature/mejorar-mensajes-error`  
**Base:** `main`
