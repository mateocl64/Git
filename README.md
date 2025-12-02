# Mi Primer Repositorio DevOps

Este repositorio fue creado como parte de las **Actividades 4.1, 4.2 y 4.3** del curso de DevOps.

## Descripción del Proyecto

Este proyecto demuestra el uso completo de Git y las prácticas profesionales de control de versiones, incluyendo:

### Actividad 4.1: Mi Primer Repo DevOps
- ✅ Inicialización de un repositorio local
- ✅ Configuración de `.gitignore`
- ✅ Realización de commits significativos
- ✅ Conexión con un repositorio remoto

### Actividad 4.2: Ramas y Conflictos Controlados
- ✅ Trabajo con ramas (branches)
- ✅ Desarrollo en paralelo
- ✅ Manejo de conflictos y merges
- ✅ Integración de features

### Actividad 4.3: Flujo Colaborativo con Pull Requests ⭐ NUEVO
- ✅ Guía de contribución (CONTRIBUTING.md)
- ✅ Simulación de múltiples colaboradores
- ✅ Pull Requests documentados (2 PRs completos)
- ✅ Code Review profesional
- ✅ Validación de errores implementada
- ✅ Sistema de logging completo
- ✅ 12 tests automatizados pasando

## Tecnologías Utilizadas

- **Control de versiones:** Git
- **Plataforma:** GitHub
- **Lenguaje:** Python 3.x
- **Documentación:** Markdown
- **Testing:** Custom test suite
- **Logging:** Python logging module

## Estructura del Proyecto

```
Git/
├── .git/                               # Directorio de Git
├── .gitignore                          # Patrones de archivos a ignorar
├── README.md                           # Este archivo
├── CONTRIBUTING.md                     # ⭐ Guía de contribución
├── config.json                         # Configuración del proyecto
│
├── src/
│   ├── app.py                         # Aplicación con validación + logging
│   └── test_app.py                    # Suite de tests (12 tests)
│
└── docs/
    ├── comandos-git.md                # Comandos básicos de Git
    ├── COMANDOS-RAMAS-Y-CONFLICTOS.md # Comandos de ramas
    │
    ├── PR-001-VALIDACION-ERRORES.md   # ⭐ Documentación PR #1
    ├── CODE-REVIEW-PR-001.md          # ⭐ Code Review PR #1
    ├── PR-002-LOGGING.md              # ⭐ Documentación PR #2
    │
    ├── ACTIVIDAD-4.3-PULL-REQUESTS.md # ⭐ Proceso de PRs
    ├── ENTREGA-4.3.md                 # ⭐ Documento de entrega
    │
    ├── ACTIVIDAD-4.2-CONFLICTOS.md    # Resolución de conflictos
    ├── ENTREGA-4.2.md                 # Entrega actividad 4.2
    ├── ENTREGA.md                     # Entrega actividad 4.1
    └── ...                            # Otros documentos
```

## 📊 Estadísticas del Repositorio

- **Total de commits:** 25+ commits
- **Branches activos:** 5 branches
- **Pull Requests:** 2 PRs mergeados
- **Tests:** 12 tests automatizados ✅
- **Líneas de documentación:** 2500+ líneas
- **Features implementadas:** Validación de errores + Logging

## 🎯 Features Implementadas

### 1. Sistema de Validación de Errores (PR #1)
```python
# Validación de tipos y valores
def saludar(nombre):
    if not nombre or not isinstance(nombre, str):
        raise ValueError("El nombre debe ser una cadena no vacía")
    return f"👋 ¡Hola, {nombre}!"

def calcular_progreso(completadas, totales):
    # Validación de tipos (TypeError)
    # Validación de valores (ValueError)
    # Validación de rangos
    return (completadas / totales) * 100
```

### 2. Sistema de Logging Completo (PR #2)
```python
import logging

logger = logging.getLogger(__name__)

# Logging multinivel (INFO, ERROR, DEBUG, WARNING)
logger.info("Saludo exitoso para: Juan")
logger.error("Validación fallida: nombre vacío")
logger.debug("Calculando progreso: 7/10")
```

## 📝 Commits Realizados

Este repositorio contiene **25+ commits significativos** organizados en:

### Actividad 4.1 (13 commits)
1-13: Inicialización, .gitignore, docs, código base, conexión remoto

### Actividad 4.2 (6 commits)
14-19: Branches, desarrollo paralelo, merge con conflicto, documentación

### Actividad 4.3 (8 commits) ⭐ NUEVO
20. `docs:` Agregar guía de contribución (CONTRIBUTING.md)
21. `feat:` Agregar validación de errores y tests mejorados
22. `docs:` Agregar documentación y code review de PR #1
23. `merge:` PR #1 - Agregar validación de errores (#1)
24. `feat:` Agregar sistema de logging completo
25. `docs:` Agregar documentación de PR #2 (logging)
26. `merge:` PR #2 - Agregar sistema de logging (#2)
27. `docs:` Documentación completa de Actividad 4.3

## 🚀 Cómo Usar Este Proyecto

### Clonar el repositorio
```bash
git clone https://github.com/mateocl64/Git.git
cd Git
```

### Ejecutar la aplicación
```bash
python src/app.py
```

### Ejecutar los tests
```bash
python src/test_app.py
```

**Salida esperada:** ✅ 12/12 tests pasando

## 📚 Documentación Importante

### Para Colaboradores
- **CONTRIBUTING.md** - Guía completa de cómo contribuir al proyecto

### Documentación de Actividades
- **docs/ENTREGA.md** - Evidencia de Actividad 4.1
- **docs/ENTREGA-4.2.md** - Evidencia de Actividad 4.2
- **docs/ENTREGA-4.3.md** - ⭐ Evidencia de Actividad 4.3

### Documentación de Pull Requests
- **docs/PR-001-VALIDACION-ERRORES.md** - Documentación del PR #1
- **docs/CODE-REVIEW-PR-001.md** - Code Review profesional
- **docs/PR-002-LOGGING.md** - Documentación del PR #2
- **docs/ACTIVIDAD-4.3-PULL-REQUESTS.md** - Proceso completo de PRs

### Guías de Git
- **docs/comandos-git.md** - Comandos básicos de Git
- **docs/COMANDOS-RAMAS-Y-CONFLICTOS.md** - Comandos de ramas y merges
- **docs/DIAGRAMA-RAMAS.md** - Visualización de branches

## 🔗 Próximos Pasos

1. Crear un repositorio en GitHub o GitLab
2. Conectar este repositorio local con el remoto
3. Subir todos los cambios con `git push`

## 🤝 Contribuir

¿Quieres contribuir a este proyecto? Lee nuestra **[Guía de Contribución](CONTRIBUTING.md)** para conocer:
- 📋 Proceso de Pull Request
- ✅ Checklist de contribución
- 📏 Estándares de código
- 🔍 Proceso de code review

## 📚 Recursos y Referencias

### Documentación Interna
- **Comandos Git:** `docs/comandos-git.md`
- **Comandos de Ramas:** `docs/COMANDOS-RAMAS-Y-CONFLICTOS.md`
- **Guía de Contribución:** `CONTRIBUTING.md`

### Enlaces Útiles
- [Repositorio en GitHub](https://github.com/mateocl64/Git)
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/)

## 👨‍💻 Autor

**Estudiante DevOps**  
Curso de DevOps - Módulo de Control de Versiones

## 📅 Historial de Actividades

| Actividad | Fecha | Estado |
|-----------|-------|--------|
| 4.1 - Mi Primer Repo DevOps | Diciembre 2, 2025 | ✅ Completada |
| 4.2 - Ramas y Conflictos | Diciembre 2, 2025 | ✅ Completada |
| 4.3 - Pull Requests | Diciembre 2, 2025 | ✅ Completada |

## 📝 Licencia

Este proyecto es parte de un curso educativo de DevOps.

---

⭐ **Si este proyecto te ayudó a aprender Git, dale una estrella!**
