# 🔄 Plan de Rollback - Actividad 6.3

**Propósito:** Definir un procedimiento claro, rápido y confiable para revertir a una versión anterior estable en caso de problemas durante o después del despliegue.

**Última actualización:** 2025-12-02  
**Versión:** 1.0.0  
**Tiempo Estimado de Ejecución:** 3-5 minutos

---

## 📋 Índice

1. [Principios del Rollback](#principios-del-rollback)
2. [Estrategia de Versionado](#estrategia-de-versionado)
3. [Procedimiento de Rollback Manual](#procedimiento-de-rollback-manual)
4. [Script de Rollback Automatizado](#script-de-rollback-automatizado)
5. [Casos de Uso y Ejemplos](#casos-de-uso-y-ejemplos)
6. [Verificación Post-Rollback](#verificación-post-rollback)
7. [Simulación de Rollback](#simulación-de-rollback)

---

## 🎯 Principios del Rollback

### 1. Simplicidad
- **Rollback debe ser más simple que el despliegue**
- Un único comando o script debe revertir completamente
- No requiere decisiones complejas bajo presión

### 2. Rapidez
- **Tiempo objetivo: < 5 minutos**
- Minimizar downtime en producción
- Automatización para reducir errores humanos

### 3. Confiabilidad
- **100% de tasa de éxito esperada**
- Siempre revertir a una versión conocida y estable
- No introducir nuevos problemas durante el rollback

### 4. Trazabilidad
- **Registrar todos los rollbacks**
- Documentar razón del rollback
- Mantener historial para análisis post-mortem

---

## 🏷️ Estrategia de Versionado

### Versionado Semántico (SemVer)

Usamos **Semantic Versioning 2.0.0**: `vMAJOR.MINOR.PATCH`

```
v1.2.3
│ │ │
│ │ └─── PATCH: Bugfixes, no breaking changes
│ └───── MINOR: New features, backward compatible
└─────── MAJOR: Breaking changes, incompatible API
```

### Ejemplos de Versionado

| Cambio | Versión Anterior | Versión Nueva | Justificación |
|--------|------------------|---------------|---------------|
| Agregar nueva función | v1.0.0 | v1.1.0 | MINOR: Nueva feature |
| Corregir bug | v1.1.0 | v1.1.1 | PATCH: Bugfix |
| Cambiar API | v1.1.1 | v2.0.0 | MAJOR: Breaking change |
| Hotfix crítico | v2.0.0 | v2.0.1 | PATCH: Security fix |

### Tags de Git

**Cada versión estable debe tener un tag de Git:**

```powershell
# Crear tag anotado con mensaje
git tag -a v1.0.0 -m "Release v1.0.0: Initial stable release"

# Push del tag al repositorio remoto
git push origin v1.0.0

# Listar todos los tags
git tag -l

# Ver información de un tag específico
git show v1.0.0
```

### Tags de Docker Images

**Cada imagen Docker debe tener múltiples tags:**

1. **Tag de versión específica:** `devops-app:v1.0.0`
2. **Tag latest:** `devops-app:latest` (siempre apunta a la última versión estable)
3. **Tag de commit SHA:** `devops-app:abc1234` (para trazabilidad exacta)

```powershell
# Build con múltiples tags
docker build -t devops-app:v1.0.0 -t devops-app:latest .

# Tag adicional con commit SHA
docker tag devops-app:v1.0.0 devops-app:$(git rev-parse --short HEAD)

# Listar imágenes
docker images | grep devops-app
```

---

## 🔧 Procedimiento de Rollback Manual

### Paso 1: Identificar Versión Objetivo

**Determinar a qué versión queremos revertir:**

```powershell
# Listar todas las versiones (tags) disponibles
git tag -l

# Output esperado:
# v1.0.0
# v1.1.0
# v1.2.0
# v2.0.0  <-- Versión actual con problemas

# Seleccionar versión anterior estable
$TARGET_VERSION = "v1.2.0"
```

**Verificar que la imagen Docker existe:**

```powershell
# Listar imágenes Docker locales
docker images | grep devops-app

# Si la imagen no existe localmente, hacer pull (si está en registry)
# docker pull registry.example.com/devops-app:v1.2.0
```

### Paso 2: Detener Versión Problemática

**Detener y remover containers actuales:**

```powershell
# Detener servicios con Docker Compose
docker-compose down

# Verificar que todo está detenido
docker ps -a | grep devops-app

# Remover container si existe
docker rm -f devops-app-container 2>$null
```

### Paso 3: Checkout de la Versión Objetivo

**Revertir código al tag de la versión estable:**

```powershell
# Checkout del tag específico
git checkout tags/v1.2.0

# Verificar que estamos en el tag correcto
git describe --tags
# Output: v1.2.0

# Ver archivos modificados
git status
```

### Paso 4: Build de la Imagen (si no existe)

**Si la imagen Docker no existe localmente, hacer build:**

```powershell
# Build de la imagen con tag de versión
docker build -t devops-app:v1.2.0 .

# Actualizar tag 'latest' para apuntar a esta versión
docker tag devops-app:v1.2.0 devops-app:latest

# Verificar imágenes
docker images | grep devops-app
```

### Paso 5: Actualizar docker-compose.yml (si necesario)

**Asegurar que docker-compose.yml usa la versión correcta:**

```powershell
# Verificar contenido de docker-compose.yml
Get-Content docker-compose.yml | Select-String "image:"

# Si es necesario, actualizar manualmente a:
# image: devops-app:v1.2.0
```

### Paso 6: Desplegar Versión Anterior

**Levantar servicios con la versión estable:**

```powershell
# Iniciar servicios con Docker Compose
docker-compose up -d

# Verificar que el container está corriendo
docker ps | grep devops-app

# Ver logs en tiempo real
docker-compose logs -f
```

### Paso 7: Verificar Rollback Exitoso

**Smoke tests para confirmar que todo funciona:**

```powershell
# 1. Verificar que el container completó exitosamente (para oneshot apps)
docker ps -a | grep devops-app
# Estado esperado: Exited (0)

# 2. Ver logs completos
docker logs devops-app-container

# 3. Verificar output de la aplicación
docker run --rm devops-app:v1.2.0

# 4. Verificar logs persistentes
Get-Content .\logs\app.log -Tail 20

# 5. Verificar que no hay errores
docker inspect devops-app-container --format='{{.State.ExitCode}}'
# Expected: 0
```

### Paso 8: Volver a Main Branch (Opcional)

**Si necesitamos seguir trabajando en main:**

```powershell
# Volver a la rama main
git checkout main

# O crear una rama para el hotfix
git checkout -b hotfix/v2.0.1
```

### Paso 9: Documentar el Rollback

**Registrar el rollback para análisis:**

```powershell
# Crear entrada en CHANGELOG.md
# Crear incident report
# Notificar al equipo
```

---

## 🤖 Script de Rollback Automatizado

### rollback.ps1

**Script PowerShell para ejecutar rollback con un solo comando:**

```powershell
# scripts/rollback.ps1
# Script de rollback automatizado para DevOps App
# Uso: .\scripts\rollback.ps1 -TargetVersion "v1.2.0"

param(
    [Parameter(Mandatory=$true)]
    [string]$TargetVersion,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipConfirmation
)

# Colores para output
function Write-Success { Write-Host $args -ForegroundColor Green }
function Write-Error { Write-Host $args -ForegroundColor Red }
function Write-Info { Write-Host $args -ForegroundColor Cyan }
function Write-Warning { Write-Host $args -ForegroundColor Yellow }

Write-Info "============================================="
Write-Info "🔄 ROLLBACK SCRIPT - DevOps App"
Write-Info "============================================="
Write-Info "Versión objetivo: $TargetVersion"
Write-Info "Fecha/Hora: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Info ""

# 1. Verificar que el tag existe
Write-Info "[1/8] Verificando que el tag existe..."
$tagExists = git tag -l $TargetVersion
if (-not $tagExists) {
    Write-Error "❌ ERROR: El tag '$TargetVersion' no existe"
    Write-Info "Tags disponibles:"
    git tag -l
    exit 1
}
Write-Success "✅ Tag '$TargetVersion' encontrado"

# 2. Confirmar con el usuario (a menos que -SkipConfirmation)
if (-not $SkipConfirmation) {
    Write-Warning ""
    Write-Warning "⚠️  ADVERTENCIA: Esto detendrá la aplicación actual y revertirá a $TargetVersion"
    $confirmation = Read-Host "¿Continuar con el rollback? (y/N)"
    if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
        Write-Info "Rollback cancelado por el usuario"
        exit 0
    }
}

# 3. Detener versión actual
Write-Info ""
Write-Info "[2/8] Deteniendo versión actual..."
docker-compose down 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Success "✅ Servicios detenidos"
} else {
    Write-Warning "⚠️  No había servicios corriendo o ya estaban detenidos"
}

# Remover container si existe
docker rm -f devops-app-container 2>$null

# 4. Guardar estado actual (crear tag de backup)
Write-Info ""
Write-Info "[3/8] Guardando estado actual..."
$currentBranch = git branch --show-current
$backupTag = "backup-before-rollback-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
git tag -a $backupTag -m "Backup antes de rollback a $TargetVersion" 2>$null
Write-Success "✅ Backup creado: $backupTag"

# 5. Checkout del tag objetivo
Write-Info ""
Write-Info "[4/8] Haciendo checkout del tag $TargetVersion..."
git checkout tags/$TargetVersion 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Success "✅ Checkout exitoso a $TargetVersion"
} else {
    Write-Error "❌ ERROR: No se pudo hacer checkout del tag"
    exit 1
}

# 6. Build de la imagen Docker
Write-Info ""
Write-Info "[5/8] Construyendo imagen Docker..."
docker build -t devops-app:$TargetVersion -t devops-app:latest . 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Success "✅ Imagen Docker construida: devops-app:$TargetVersion"
} else {
    Write-Error "❌ ERROR: Fallo en el build de la imagen Docker"
    exit 1
}

# 7. Desplegar versión anterior
Write-Info ""
Write-Info "[6/8] Desplegando versión $TargetVersion..."
docker-compose up -d 2>&1 | Out-Null
if ($LASTEXITCODE -eq 0) {
    Write-Success "✅ Servicios desplegados con docker-compose"
} else {
    Write-Error "❌ ERROR: Fallo al desplegar con docker-compose"
    exit 1
}

# Esperar un poco para que el container inicie
Start-Sleep -Seconds 3

# 8. Verificar rollback
Write-Info ""
Write-Info "[7/8] Verificando rollback..."

# Verificar que el container ejecutó
$containerStatus = docker ps -a --filter "name=devops-app-container" --format "{{.Status}}"
Write-Info "Estado del container: $containerStatus"

# Verificar exit code
$exitCode = docker inspect devops-app-container --format='{{.State.ExitCode}}' 2>$null
if ($exitCode -eq "0") {
    Write-Success "✅ Container ejecutó exitosamente (Exit Code: 0)"
} else {
    Write-Error "❌ Container terminó con errores (Exit Code: $exitCode)"
}

# Ver últimas líneas de logs
Write-Info ""
Write-Info "Últimas líneas de logs:"
docker logs devops-app-container --tail 10

# 9. Resumen final
Write-Info ""
Write-Info "[8/8] Rollback completado"
Write-Success "============================================="
Write-Success "✅ ROLLBACK EXITOSO"
Write-Success "============================================="
Write-Info "Versión desplegada: $TargetVersion"
Write-Info "Backup creado: $backupTag"
Write-Info "Hora de finalización: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Info ""
Write-Warning "⚠️  IMPORTANTE: Ahora estás en 'detached HEAD' state"
Write-Info "Para volver a main: git checkout main"
Write-Info "Para ver logs: docker logs devops-app-container"
Write-Info "Para detener: docker-compose down"
Write-Info ""

# Preguntar si quiere ver los logs completos
if (-not $SkipConfirmation) {
    $viewLogs = Read-Host "¿Ver logs completos? (y/N)"
    if ($viewLogs -eq 'y' -or $viewLogs -eq 'Y') {
        docker logs devops-app-container
    }
}
```

### Uso del Script

```powershell
# Uso básico (con confirmación)
.\scripts\rollback.ps1 -TargetVersion "v1.2.0"

# Sin confirmación (automatizado, peligroso)
.\scripts\rollback.ps1 -TargetVersion "v1.2.0" -SkipConfirmation

# Ver ayuda
Get-Help .\scripts\rollback.ps1 -Full
```

---

## 📝 Casos de Uso y Ejemplos

### Caso 1: Rollback por Error en Tests

**Escenario:** Desplegamos v2.0.0 pero 4 de 12 tests fallan en producción.

```powershell
# Situación detectada
Write-Host "❌ Tests fallando: 4/12"
Write-Host "❌ Coverage: 65% (objetivo: 85%)"

# Decisión: Rollback inmediato
.\scripts\rollback.ps1 -TargetVersion "v1.2.0"

# Resultado esperado
# ✅ Rollback exitoso a v1.2.0
# ✅ Tests: 12/12 pasando
# ✅ Coverage: 85%
```

### Caso 2: Rollback por Vulnerabilidad Crítica

**Escenario:** Trivy detecta una vulnerabilidad CRITICAL en v2.1.0.

```powershell
# Situación detectada
docker run --rm aquasec/trivy:latest image devops-app:v2.1.0
# Output: CRITICAL: CVE-2024-XXXXX (Score: 9.8)

# Decisión: Rollback inmediato
.\scripts\rollback.ps1 -TargetVersion "v2.0.1" -SkipConfirmation

# Resultado esperado
# ✅ Rollback a v2.0.1 sin vulnerabilidades CRITICAL
# ✅ Crear hotfix/v2.1.1 para corregir
```

### Caso 3: Rollback por Performance Degradada

**Escenario:** v3.0.0 tarda 15 segundos en ejecutar (antes: 3 segundos).

```powershell
# Situación detectada
Measure-Command { docker run --rm devops-app:v3.0.0 }
# Output: TotalSeconds: 15.234

# Decisión: Rollback y análisis
.\scripts\rollback.ps1 -TargetVersion "v2.2.0"

# Verificar performance de versión anterior
Measure-Command { docker run --rm devops-app:v2.2.0 }
# Output: TotalSeconds: 3.123

# ✅ Performance restaurada
```

### Caso 4: Rollback Preventivo (Antes de Problema Grave)

**Escenario:** Detectamos warning en logs que podría escalar.

```powershell
# Situación detectada
docker logs devops-app-container | Select-String "WARNING"
# Output: 25 warnings detectados en 2 minutos

# Decisión: Rollback preventivo
.\scripts\rollback.ps1 -TargetVersion "v2.1.1"

# Análisis post-rollback
# ✅ Warnings eliminados
# ✅ Crear ticket para investigar causa raíz
```

---

## ✅ Verificación Post-Rollback

### Checklist de Verificación

Después de ejecutar un rollback, verificar:

#### 1. Container Status

```powershell
# Verificar que el container completó exitosamente
docker ps -a | grep devops-app

# Expected output (para oneshot apps):
# devops-app-container   devops-app:v1.2.0   "python src/app.py"   1 minute ago   Exited (0)
```

#### 2. Application Logs

```powershell
# Ver logs completos del container
docker logs devops-app-container

# Verificar que contiene:
# - "=== Iniciando aplicación DevOps ==="
# - "Inicio de la aplicación"
# - "¡Hola! 👋 Bienvenido"
# - "Progreso: 75%"
# - "Estadísticas del sistema"
# - "Aplicación finalizada exitosamente"
# - "=== Aplicación finalizada exitosamente ==="
```

#### 3. Persistent Logs

```powershell
# Verificar logs persistentes
Get-Content .\logs\app.log -Tail 20

# Verificar que contiene timestamps y niveles correctos
# Example:
# 2025-12-02 10:30:45,123 - INFO - Inicio de la aplicación
# 2025-12-02 10:30:45,456 - INFO - Aplicación finalizada exitosamente
```

#### 4. Exit Code

```powershell
# Verificar exit code del container
docker inspect devops-app-container --format='{{.State.ExitCode}}'

# Expected: 0
```

#### 5. Functional Testing

```powershell
# Ejecutar container manualmente para verificar funcionalidad
docker run --rm devops-app:v1.2.0

# Verificar output completo y correcto
# Todas las funciones deben ejecutarse sin errores
```

#### 6. Git State

```powershell
# Verificar que estamos en el tag correcto
git describe --tags

# Output esperado: v1.2.0

# Ver estado de Git
git status

# Output esperado: HEAD detached at v1.2.0
```

#### 7. Docker Images

```powershell
# Listar imágenes Docker
docker images | grep devops-app

# Verificar que existen:
# - devops-app:v1.2.0
# - devops-app:latest (apuntando a v1.2.0)
```

#### 8. Performance

```powershell
# Medir tiempo de ejecución
Measure-Command { docker run --rm devops-app:v1.2.0 }

# Verificar que está dentro de lo esperado (< 5 segundos)
```

#### 9. Resources

```powershell
# Verificar uso de recursos (si el container sigue corriendo)
docker stats devops-app-container --no-stream

# Verificar:
# - CPU: < 50%
# - Memory: < 512MB
```

#### 10. Security

```powershell
# Re-ejecutar Trivy scan
docker run --rm aquasec/trivy:latest image devops-app:v1.2.0

# Verificar:
# - CRITICAL: 0
# - HIGH: Aceptable (< 5)
```

---

## 🎭 Simulación de Rollback

### Preparación del Escenario

**Vamos a simular un despliegue problemático y su rollback:**

#### Paso 1: Crear Versión Estable (v1.0.0)

```powershell
# Asegurarnos de estar en main con código funcionando
git checkout main
git pull origin main

# Ejecutar tests para confirmar estabilidad
pytest tests/ -v

# Crear tag v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0: Versión estable inicial"
git push origin v1.0.0

# Build de imagen Docker
docker build -t devops-app:v1.0.0 -t devops-app:latest .

# Desplegar y verificar
docker-compose up -d
docker logs devops-app-container

# ✅ v1.0.0 funcionando correctamente
```

#### Paso 2: Crear Versión Problemática (v2.0.0)

```powershell
# Crear rama para nueva versión
git checkout -b release/v2.0.0

# INTRODUCIR UN ERROR INTENCIONAL
# Editar src/app.py para introducir un error
```

**Editar `src/app.py` con error intencional:**

```python
# En src/app.py, línea ~40, cambiar:

# ANTES (correcto):
def calcular_progreso():
    """Calcula y muestra el progreso."""
    progreso = 75
    
# DESPUÉS (con error):
def calcular_progreso():
    """Calcula y muestra el progreso."""
    progreso = 75 / 0  # ⚠️ ERROR INTENCIONAL: División por cero
```

**Continuar con el despliegue problemático:**

```powershell
# Commit del error (simulando que no lo detectamos)
git add src/app.py
git commit -m "feat: agregar nueva funcionalidad (con error oculto)"

# Merge a main (simulando PR aprobado)
git checkout main
git merge release/v2.0.0

# Crear tag v2.0.0
git tag -a v2.0.0 -m "Release v2.0.0: Nueva versión con features"
git push origin v2.0.0
git push origin main

# Build y deploy de versión problemática
docker build -t devops-app:v2.0.0 -t devops-app:latest .
docker-compose up -d

# ❌ PROBLEMA DETECTADO: Container crashea
docker logs devops-app-container

# Output esperado:
# ...
# ZeroDivisionError: division by zero
# ...
```

#### Paso 3: Ejecutar Rollback

```powershell
# DECISIÓN: Rollback inmediato a v1.0.0

# Opción A: Usar script automatizado
.\scripts\rollback.ps1 -TargetVersion "v1.0.0"

# Opción B: Manual (si no tenemos el script)
docker-compose down
git checkout tags/v1.0.0
docker build -t devops-app:v1.0.0 -t devops-app:latest .
docker-compose up -d

# Verificar rollback exitoso
docker logs devops-app-container

# ✅ Output esperado: Aplicación ejecuta correctamente sin errores
```

#### Paso 4: Verificar y Documentar

```powershell
# Verificar funcionalidad completa
docker run --rm devops-app:v1.0.0

# Verificar exit code
docker inspect devops-app-container --format='{{.State.ExitCode}}'
# Expected: 0

# Verificar logs persistentes
Get-Content .\logs\app.log -Tail 20

# Crear incident report
# Documentar en CHANGELOG.md
```

#### Paso 5: Corregir el Error

```powershell
# Volver a main para crear hotfix
git checkout main

# Crear rama de hotfix
git checkout -b hotfix/v2.0.1

# Corregir el error en src/app.py
# Eliminar la división por cero

# Commit de la corrección
git add src/app.py
git commit -m "fix: corregir división por cero en calcular_progreso"

# Merge a main
git checkout main
git merge hotfix/v2.0.1

# Crear tag v2.0.1 (versión corregida)
git tag -a v2.0.1 -m "Release v2.0.1: Hotfix división por cero"
git push origin v2.0.1
git push origin main

# Deploy de versión corregida
docker build -t devops-app:v2.0.1 -t devops-app:latest .
docker-compose up -d

# ✅ Verificar que ahora funciona correctamente
docker logs devops-app-container
```

---

## 📊 Métricas de Rollback

### Tiempos de Ejecución (Objetivo)

| Fase | Tiempo | Acumulado |
|------|--------|-----------|
| Detección del problema | 0-5 min | 0-5 min |
| Decisión de rollback | 0-2 min | 0-7 min |
| Ejecución del rollback | 2-3 min | 2-10 min |
| Verificación | 1-2 min | 3-12 min |
| **TOTAL** | **3-12 min** | **3-12 min** |

### Criterios de Éxito

- ✅ **Tiempo total < 15 minutos**: Desde detección hasta verificación completa
- ✅ **Exit code 0**: Container ejecuta sin errores
- ✅ **Logs limpios**: No errores en application logs
- ✅ **Funcionalidad restaurada**: Todas las funciones operativas
- ✅ **Performance normal**: Tiempo de ejecución < 5 segundos

---

## 📚 Referencias

### Documentos Relacionados

- **Checklist de Despliegue:** `docs/CHECKLIST-DESPLIEGUE.md`
- **Pipeline de CD:** `docs/ACTIVIDAD-6.2-CD-PIPELINE.md`
- **CHANGELOG:** `CHANGELOG.md`

### Scripts y Archivos

- **Script de Rollback:** `scripts/rollback.ps1`
- **Docker Compose:** `docker-compose.yml`
- **Dockerfile:** `Dockerfile`
- **CD Workflow:** `.github/workflows/cd.yml`

### Comandos Útiles

```powershell
# Ver todos los tags
git tag -l

# Ver detalles de un tag
git show v1.0.0

# Crear tag anotado
git tag -a v1.0.0 -m "Mensaje"

# Push de un tag
git push origin v1.0.0

# Checkout de un tag
git checkout tags/v1.0.0

# Volver a main
git checkout main

# Listar imágenes Docker
docker images | grep devops-app

# Ver logs de container
docker logs devops-app-container

# Ejecutar rollback script
.\scripts\rollback.ps1 -TargetVersion "v1.0.0"
```

---

## 🎓 Lecciones Aprendidas

### Do's (Hacer)

1. ✅ **Siempre crear tags de versiones estables**
2. ✅ **Mantener múltiples versiones de imágenes Docker**
3. ✅ **Documentar cada despliegue y rollback**
4. ✅ **Automatizar el proceso de rollback**
5. ✅ **Probar el rollback periódicamente (fire drills)**
6. ✅ **Mantener logs detallados de todo**

### Don'ts (No Hacer)

1. ❌ **No sobrescribir tags existentes**
2. ❌ **No eliminar versiones antiguas inmediatamente**
3. ❌ **No hacer rollback sin verificar disponibilidad de versión anterior**
4. ❌ **No omitir la documentación del rollback**
5. ❌ **No realizar rollback sin notificar al equipo**

---

**Versión del Documento:** 1.0.0  
**Última Revisión:** 2025-12-02  
**Próxima Revisión:** Después de cada rollback ejecutado
