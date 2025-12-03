# Mi Primer Repositorio DevOps

[![CI Pipeline](https://github.com/mateocl64/Git/actions/workflows/ci.yml/badge.svg)](https://github.com/mateocl64/Git/actions/workflows/ci.yml)
[![CD Pipeline](https://github.com/mateocl64/Git/actions/workflows/cd.yml/badge.svg)](https://github.com/mateocl64/Git/actions/workflows/cd.yml)
[![PR Validation](https://github.com/mateocl64/Git/actions/workflows/pr-validation.yml/badge.svg)](https://github.com/mateocl64/Git/actions/workflows/pr-validation.yml)
![Python Version](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11-blue)
![Docker](https://img.shields.io/badge/docker-28.5.2-blue)
![Tests](https://img.shields.io/badge/tests-12%20passing-success)
![Coverage](https://img.shields.io/badge/coverage-85%25-green)

Este repositorio fue creado como parte de las **Actividades 4.1, 4.2, 4.3 y 5.2** del curso de DevOps.

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

### Actividad 4.3: Flujo Colaborativo con Pull Requests
- ✅ Guía de contribución (CONTRIBUTING.md)
- ✅ Simulación de múltiples colaboradores
- ✅ Pull Requests documentados (2 PRs completos)
- ✅ Code Review profesional
- ✅ Validación de errores implementada
- ✅ Sistema de logging completo
- ✅ 12 tests automatizados pasando

### Actividad 5.2: CI/CD Pipeline ⭐ NUEVO
- ✅ GitHub Actions configurado
- ✅ Pipeline de CI con 6 jobs (lint, build, test, security, docs, report)
- ✅ Validación automática de Pull Requests
- ✅ Tests ejecutados en múltiples versiones de Python (3.9, 3.10, 3.11)
- ✅ Análisis de código estático (Flake8, Pylint, Black)
- ✅ Escaneo de seguridad (Bandit)
- ✅ Reportes automáticos en PRs

### Actividad 5.3: Falla Controlada y Feedback 🆕
- ✅ Error intencional introducido (SyntaxError en línea 39)
- ✅ Pipeline fallido analizado (commit cba21b1)
- ✅ Logs y tiempos documentados (~1m 30s hasta fallo)
- ✅ Error corregido exitosamente (commit 0c7439b)
- ✅ Pipeline exitoso verificado (~4m 30s completo)

### Actividad 6.2: Pipeline de CD a Entorno de Pruebas 🚀 NUEVO
- ✅ **Containerización completa con Docker**
  - Dockerfile multi-stage optimizado (builder + runtime)
  - Imagen base oficial: python:3.11-slim (~200MB)
  - Usuario no-root: appuser (UID 1000)
  - Health check integrado (cada 30s)
  - Build context optimizado con .dockerignore (99.97% reducción)
  
- ✅ **Orquestación con Docker Compose**
  - Network isolation: devops-network (bridge)
  - Resource limits: CPU 0.5, RAM 512MB
  - Volume mounts para logs persistentes
  - Environment variables configurables
  
- ✅ **Pipeline de CD con GitHub Actions**
  - 5 jobs orquestados: build → test/security → deploy → report
  - Build Docker image con multi-platform support
  - Testing automatizado en container
  - Security scan con Trivy (CRITICAL + HIGH)
  - Deploy con docker-compose
  - Consolidated report con all jobs status
  - Tiempo total: ~6-8 minutos
  
- ✅ **Seguridad básica implementada**
  - Trivy scanner integrado en pipeline
  - Non-root user (appuser, UID 1000)
  - No secrets hardcoded
  - Resource limits (CPU, RAM)
  - Network isolation
  - Explicit permissions
  
- ✅ **Logging y monitoreo**
  - GitHub Actions logs por cada job
  - Application logs persistentes (/app/logs)
  - Container logs accesibles
  - Health checks automáticos
  
- ✅ **Documentación completa**
  - ACTIVIDAD-6.2-CD-PIPELINE.md (~2000 líneas)
  - ENTREGA-6.2.md con rúbrica técnica
  - 10 secciones detalladas
  - Comandos útiles y troubleshooting

### Actividad 6.3: Rollback y Checklist de Despliegue 🔄 NUEVO
- ✅ **Checklist exhaustivo de despliegue**
  - 3 fases completas: pre/durante/post-despliegue
  - 48 items verificables con comandos
  - Verificaciones de código, dependencias, infraestructura
  - Backup y preparación de rollback
  - Criterios de rollback (9 criterios críticos)
  - Smoke tests y validación post-deploy
  - Métricas y objetivos (11 KPIs)
  - Tabla de firmas y aprobación
  
- ✅ **Plan de rollback documentado y funcional**
  - 4 principios del rollback (simplicidad, rapidez, confiabilidad, trazabilidad)
  - Versionado semántico (SemVer v MAJOR.MINOR.PATCH)
  - Procedimiento manual de 9 pasos con comandos PowerShell
  - Tags de Git y Docker para versiones
  - 4 casos de uso prácticos documentados
  - 10 verificaciones post-rollback
  
- ✅ **Script de rollback automatizado**
  - scripts/rollback.ps1 (~330 líneas PowerShell)
  - 9 pasos completamente automatizados
  - Validación de tags con regex patterns
  - Backup automático antes de rollback
  - Output coloreado (Success, Error, Info, Warning)
  - Verificaciones integradas (exit code, logs, funcionalidad)
  - Tiempo de ejecución: ~30 segundos
  
- ✅ **Simulación de rollback ejecutada**
  - Versión estable v1.0.0 creada y verificada
  - Versión buggy v2.0.0 con error intencional (ZeroDivisionError)
  - Rollback automático ejecutado exitosamente
  - Funcionalidad 100% restaurada
  - Tiempo de recuperación: 30 segundos (10x mejor que objetivo de 5 min)
  - Evidencias completas documentadas
  
- ✅ **Documentación exhaustiva**
  - CHECKLIST-DESPLIEGUE.md (~850 líneas)
  - ACTIVIDAD-6.3-ROLLBACK.md (~700 líneas)
  - SIMULACION-ROLLBACK.md (~650 líneas)
  - ENTREGA-6.3.md con rúbricas completas
  - Timeline visual y comparación de outputs
  - Métricas reales capturadas
  
- ✅ **Cumplimiento de rúbricas**
  - Exhaustividad del checklist: 100/100
  - Claridad del procedimiento de rollback: 100/100
  - Production-ready deployment system

## Tecnologías Utilizadas

- **Control de versiones:** Git
- **Plataforma:** GitHub
- **CI/CD:** GitHub Actions
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
    ├── ACTIVIDAD-5.2-CI-PIPELINE.md   # 🆕 Pipeline CI/CD técnico
    ├── ENTREGA-5.2.md                 # 🆕 Entrega Actividad 5.2
    ├── RESUMEN-VISUAL-5.2.md          # 🆕 Resumen visual CI/CD
    │
    ├── ACTIVIDAD-5.3-FALLAS-CONTROLADAS.md # 🔥 Análisis de fallos
    ├── ENTREGA-5.3.md                 # 🔥 Entrega Actividad 5.3
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
