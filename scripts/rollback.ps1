# scripts/rollback.ps1
# Script de rollback automatizado para DevOps App
# Autor: DevOps Team
# Versión: 1.0.0
# Fecha: 2025-12-02
# 
# Descripción:
#   Este script automatiza el proceso de rollback a una versión anterior estable.
#   Detiene la versión actual, hace checkout del tag objetivo, construye la imagen
#   Docker y despliega la versión anterior.
#
# Uso:
#   .\scripts\rollback.ps1 -TargetVersion "v1.2.0"
#   .\scripts\rollback.ps1 -TargetVersion "v1.2.0" -SkipConfirmation
#
# Parámetros:
#   -TargetVersion: Tag de Git de la versión a la que se quiere revertir (obligatorio)
#   -SkipConfirmation: Omite la confirmación del usuario (opcional, peligroso)
#
# Ejemplo:
#   .\scripts\rollback.ps1 -TargetVersion "v1.0.0"

[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, HelpMessage="Tag de Git de la versión objetivo (ej: v1.2.0)")]
    [ValidatePattern("^v\d+\.\d+\.\d+$")]
    [string]$TargetVersion,
    
    [Parameter(Mandatory=$false, HelpMessage="Omitir confirmación del usuario (peligroso en producción)")]
    [switch]$SkipConfirmation
)

# Configuración
$ErrorActionPreference = "Stop"
$IMAGE_NAME = "devops-app"
$CONTAINER_NAME = "devops-app-container"

# Funciones de ayuda para output coloreado
function Write-Success { 
    param([string]$Message)
    Write-Host $Message -ForegroundColor Green 
}

function Write-Failure { 
    param([string]$Message)
    Write-Host $Message -ForegroundColor Red 
}

function Write-Info { 
    param([string]$Message)
    Write-Host $Message -ForegroundColor Cyan 
}

function Write-Warning { 
    param([string]$Message)
    Write-Host $Message -ForegroundColor Yellow 
}

function Write-Step {
    param([string]$StepNumber, [string]$Description)
    Write-Host ""
    Write-Info "[$StepNumber] $Description"
    Write-Host ("=" * 60) -ForegroundColor DarkGray
}

# Banner de inicio
Clear-Host
Write-Info "============================================="
Write-Info "🔄 ROLLBACK SCRIPT - DevOps App"
Write-Info "============================================="
Write-Info "Versión objetivo: $TargetVersion"
Write-Info "Fecha/Hora: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Info "Usuario: $env:USERNAME"
Write-Info "Directorio: $(Get-Location)"
Write-Info ""

# ============================================================================
# PASO 1: Verificar que el tag existe
# ============================================================================
Write-Step "1/9" "Verificando que el tag existe en el repositorio..."

try {
    $tagExists = git tag -l $TargetVersion 2>&1
    if ([string]::IsNullOrWhiteSpace($tagExists)) {
        Write-Failure "❌ ERROR: El tag '$TargetVersion' no existe en el repositorio"
        Write-Info ""
        Write-Info "Tags disponibles:"
        git tag -l | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
        Write-Info ""
        Write-Info "Sugerencia: Crear el tag con: git tag -a $TargetVersion -m 'Release $TargetVersion'"
        exit 1
    }
    Write-Success "✅ Tag '$TargetVersion' encontrado en el repositorio"
    
    # Mostrar información del tag
    $tagInfo = git show $TargetVersion --no-patch --format="%ci - %an - %s" 2>&1
    Write-Host "   Información: $tagInfo" -ForegroundColor DarkGray
}
catch {
    Write-Failure "❌ ERROR al verificar tags: $_"
    exit 1
}

# ============================================================================
# PASO 2: Confirmar con el usuario (a menos que -SkipConfirmation)
# ============================================================================
if (-not $SkipConfirmation) {
    Write-Step "2/9" "Confirmación del rollback..."
    
    Write-Warning ""
    Write-Warning "⚠️  ADVERTENCIA: Esta operación:"
    Write-Warning "   - Detendrá la aplicación actual"
    Write-Warning "   - Revertirá el código a $TargetVersion"
    Write-Warning "   - Construirá y desplegará la versión anterior"
    Write-Warning "   - Puede causar downtime temporal"
    Write-Warning ""
    
    $confirmation = Read-Host "¿Continuar con el rollback? (y/N)"
    if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
        Write-Info "Rollback cancelado por el usuario"
        exit 0
    }
    Write-Success "✅ Rollback confirmado por el usuario"
} else {
    Write-Step "2/9" "Saltando confirmación (-SkipConfirmation activado)..."
    Write-Warning "⚠️  Modo automático: No se solicitará confirmación"
}

# ============================================================================
# PASO 3: Guardar estado actual (crear backup tag)
# ============================================================================
Write-Step "3/9" "Guardando estado actual como backup..."

try {
    # Obtener rama actual
    $currentBranch = git branch --show-current 2>&1
    Write-Info "Rama actual: $currentBranch"
    
    # Crear tag de backup con timestamp
    $backupTag = "backup-before-rollback-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    git tag -a $backupTag -m "Backup antes de rollback a $TargetVersion desde $currentBranch" 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Backup creado: $backupTag"
        Write-Host "   Podrás restaurar con: git checkout tags/$backupTag" -ForegroundColor DarkGray
    } else {
        Write-Warning "⚠️  No se pudo crear tag de backup (puede estar en detached HEAD)"
    }
}
catch {
    Write-Warning "⚠️  Advertencia al crear backup: $_"
    Write-Info "Continuando con el rollback..."
}

# ============================================================================
# PASO 4: Detener versión actual
# ============================================================================
Write-Step "4/9" "Deteniendo versión actual..."

try {
    # Detener con docker-compose
    Write-Info "Ejecutando: docker-compose down"
    $composeOutput = docker-compose down 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Servicios detenidos con docker-compose"
    } else {
        Write-Warning "⚠️  docker-compose down retornó código $LASTEXITCODE"
        Write-Host "   Output: $composeOutput" -ForegroundColor DarkGray
    }
    
    # Forzar remoción del container si aún existe
    Write-Info "Verificando y removiendo container si existe..."
    $removeOutput = docker rm -f $CONTAINER_NAME 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Container '$CONTAINER_NAME' removido"
    } else {
        Write-Info "   Container no existía o ya estaba removido"
    }
    
    # Verificar que no hay containers corriendo
    $runningContainers = docker ps --filter "name=$CONTAINER_NAME" --format "{{.Names}}" 2>&1
    if ([string]::IsNullOrWhiteSpace($runningContainers)) {
        Write-Success "✅ No hay containers activos de la aplicación"
    } else {
        Write-Warning "⚠️  Advertencia: Aún hay containers corriendo: $runningContainers"
    }
}
catch {
    Write-Warning "⚠️  Advertencia al detener servicios: $_"
    Write-Info "Continuando con el rollback..."
}

# ============================================================================
# PASO 5: Hacer checkout del tag objetivo
# ============================================================================
Write-Step "5/9" "Haciendo checkout del tag $TargetVersion..."

try {
    Write-Info "Ejecutando: git checkout tags/$TargetVersion"
    $checkoutOutput = git checkout tags/$TargetVersion 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Checkout exitoso a $TargetVersion"
        
        # Verificar que estamos en el tag correcto
        $currentTag = git describe --tags 2>&1
        Write-Host "   Tag actual: $currentTag" -ForegroundColor DarkGray
        
        if ($currentTag -eq $TargetVersion) {
            Write-Success "✅ Verificación: Estamos en el tag correcto"
        } else {
            Write-Warning "⚠️  Advertencia: git describe retorna '$currentTag' (esperado: '$TargetVersion')"
        }
    } else {
        Write-Failure "❌ ERROR: No se pudo hacer checkout del tag"
        Write-Host "Output: $checkoutOutput" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Failure "❌ ERROR al hacer checkout: $_"
    exit 1
}

# ============================================================================
# PASO 6: Construir imagen Docker
# ============================================================================
Write-Step "6/9" "Construyendo imagen Docker..."

try {
    Write-Info "Ejecutando: docker build -t ${IMAGE_NAME}:${TargetVersion} -t ${IMAGE_NAME}:latest ."
    Write-Info "Esto puede tomar 1-2 minutos..."
    
    $buildStartTime = Get-Date
    $buildOutput = docker build -t "${IMAGE_NAME}:${TargetVersion}" -t "${IMAGE_NAME}:latest" . 2>&1
    $buildEndTime = Get-Date
    $buildDuration = ($buildEndTime - $buildStartTime).TotalSeconds
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Imagen Docker construida exitosamente"
        Write-Host "   Tiempo de build: $([math]::Round($buildDuration, 2)) segundos" -ForegroundColor DarkGray
        
        # Verificar imágenes creadas
        Write-Info "Verificando imágenes..."
        $images = docker images --filter "reference=${IMAGE_NAME}" --format "{{.Repository}}:{{.Tag}} - {{.Size}}" 2>&1
        $images | ForEach-Object { Write-Host "   $_" -ForegroundColor DarkGray }
        
        # Inspeccionar imagen para verificar configuración
        Write-Info "Inspeccionando imagen..."
        $imageUser = docker inspect "${IMAGE_NAME}:${TargetVersion}" --format='{{.Config.User}}' 2>&1
        $imageExposedPorts = docker inspect "${IMAGE_NAME}:${TargetVersion}" --format='{{.Config.ExposedPorts}}' 2>&1
        
        Write-Host "   User: $imageUser" -ForegroundColor DarkGray
        Write-Host "   Exposed Ports: $imageExposedPorts" -ForegroundColor DarkGray
        
    } else {
        Write-Failure "❌ ERROR: Fallo en el build de la imagen Docker"
        Write-Host "Output del build:" -ForegroundColor Red
        Write-Host $buildOutput -ForegroundColor Red
        
        # Intentar rollback del checkout
        Write-Warning "Intentando revertir checkout..."
        git checkout $currentBranch 2>&1 | Out-Null
        exit 1
    }
}
catch {
    Write-Failure "❌ ERROR durante el build: $_"
    exit 1
}

# ============================================================================
# PASO 7: Actualizar docker-compose.yml (si usa tag específico)
# ============================================================================
Write-Step "7/9" "Verificando docker-compose.yml..."

try {
    # Verificar contenido actual de docker-compose.yml
    $composeContent = Get-Content docker-compose.yml -Raw
    
    # Buscar la línea de imagen
    $imageLine = Get-Content docker-compose.yml | Select-String "image:"
    
    if ($imageLine) {
        Write-Info "Configuración actual: $($imageLine.Line.Trim())"
        
        # Si usa 'latest', no necesitamos cambiar nada
        if ($imageLine -match "latest") {
            Write-Success "✅ docker-compose.yml usa tag 'latest' - No requiere cambios"
        } else {
            Write-Info "docker-compose.yml usa tag específico - Puede requerir actualización manual"
            Write-Warning "⚠️  Asegúrate de que docker-compose.yml apunte a la versión correcta"
        }
    } else {
        Write-Warning "⚠️  No se encontró configuración de imagen en docker-compose.yml"
    }
}
catch {
    Write-Warning "⚠️  No se pudo verificar docker-compose.yml: $_"
}

# ============================================================================
# PASO 8: Desplegar versión anterior
# ============================================================================
Write-Step "8/9" "Desplegando versión $TargetVersion con docker-compose..."

try {
    Write-Info "Ejecutando: docker-compose up -d"
    $deployOutput = docker-compose up -d 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✅ Servicios desplegados con docker-compose"
    } else {
        Write-Failure "❌ ERROR: Fallo al desplegar con docker-compose"
        Write-Host "Output: $deployOutput" -ForegroundColor Red
        exit 1
    }
    
    # Esperar un poco para que el container inicie
    Write-Info "Esperando 3 segundos para que el container inicie..."
    Start-Sleep -Seconds 3
    
    # Verificar estado del container
    Write-Info "Verificando estado del container..."
    $containerStatus = docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.Names}}: {{.Status}}" 2>&1
    
    if ($containerStatus) {
        Write-Host "   $containerStatus" -ForegroundColor DarkGray
    } else {
        Write-Warning "⚠️  No se encontró el container '$CONTAINER_NAME'"
    }
}
catch {
    Write-Failure "❌ ERROR al desplegar: $_"
    exit 1
}

# ============================================================================
# PASO 9: Verificar rollback exitoso
# ============================================================================
Write-Step "9/9" "Verificando rollback..."

try {
    # 1. Verificar exit code del container
    Write-Info "Verificando exit code del container..."
    $exitCode = docker inspect $CONTAINER_NAME --format='{{.State.ExitCode}}' 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        if ($exitCode -eq "0") {
            Write-Success "✅ Container ejecutó exitosamente (Exit Code: 0)"
        } else {
            Write-Failure "❌ Container terminó con errores (Exit Code: $exitCode)"
            Write-Warning "⚠️  Revisar logs para más detalles"
        }
    } else {
        Write-Warning "⚠️  No se pudo verificar exit code del container"
    }
    
    # 2. Verificar logs del container
    Write-Info ""
    Write-Info "Últimas 15 líneas de logs del container:"
    Write-Host ("=" * 60) -ForegroundColor DarkGray
    
    $logs = docker logs $CONTAINER_NAME --tail 15 2>&1
    $logs | ForEach-Object { Write-Host $_ }
    
    Write-Host ("=" * 60) -ForegroundColor DarkGray
    
    # 3. Verificar que los logs contienen indicadores de éxito
    if ($logs -match "Aplicación finalizada exitosamente") {
        Write-Success "✅ Logs indican ejecución exitosa"
    } else {
        Write-Warning "⚠️  Logs no contienen mensaje de finalización exitosa"
    }
    
    # 4. Verificar logs persistentes
    if (Test-Path ".\logs\app.log") {
        Write-Info ""
        Write-Info "Últimas 5 líneas de logs persistentes (.\logs\app.log):"
        Get-Content ".\logs\app.log" -Tail 5 | ForEach-Object { Write-Host "   $_" -ForegroundColor DarkGray }
        Write-Success "✅ Logs persistentes disponibles"
    } else {
        Write-Warning "⚠️  No se encontraron logs persistentes en .\logs\app.log"
    }
}
catch {
    Write-Warning "⚠️  Advertencia durante verificación: $_"
}

# ============================================================================
# RESUMEN FINAL
# ============================================================================
Write-Host ""
Write-Host ""
Write-Success "============================================="
Write-Success "✅ ROLLBACK COMPLETADO"
Write-Success "============================================="
Write-Host ""
Write-Info "📊 Resumen del Rollback:"
Write-Host "   Versión desplegada: $TargetVersion" -ForegroundColor White
Write-Host "   Backup creado: $backupTag" -ForegroundColor White
Write-Host "   Hora de inicio: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor White
Write-Host "   Duración aprox: $([math]::Round(((Get-Date) - (Get-Date)).Add([TimeSpan]::FromSeconds(30)).TotalMinutes, 2)) minutos" -ForegroundColor White
Write-Host ""
Write-Warning "⚠️  IMPORTANTE: Estado de Git"
Write-Host "   Ahora estás en 'detached HEAD' state en el tag $TargetVersion" -ForegroundColor Yellow
Write-Host ""
Write-Info "📝 Próximos pasos:"
Write-Host "   1. Verificar funcionalidad: docker run --rm ${IMAGE_NAME}:${TargetVersion}" -ForegroundColor Cyan
Write-Host "   2. Ver logs completos: docker logs $CONTAINER_NAME" -ForegroundColor Cyan
Write-Host "   3. Volver a main (si necesario): git checkout main" -ForegroundColor Cyan
Write-Host "   4. Detener servicios: docker-compose down" -ForegroundColor Cyan
Write-Host "   5. Crear incident report y documentar rollback" -ForegroundColor Cyan
Write-Host ""

# Preguntar si quiere ver los logs completos
if (-not $SkipConfirmation) {
    Write-Host ""
    $viewLogs = Read-Host "¿Ver logs completos del container? (y/N)"
    if ($viewLogs -eq 'y' -or $viewLogs -eq 'Y') {
        Write-Host ""
        Write-Info "Logs completos del container:"
        Write-Host ("=" * 80) -ForegroundColor DarkGray
        docker logs $CONTAINER_NAME
        Write-Host ("=" * 80) -ForegroundColor DarkGray
    }
    
    Write-Host ""
    $testRun = Read-Host "¿Ejecutar test run del container? (y/N)"
    if ($testRun -eq 'y' -or $testRun -eq 'Y') {
        Write-Host ""
        Write-Info "Ejecutando: docker run --rm ${IMAGE_NAME}:${TargetVersion}"
        Write-Host ("=" * 80) -ForegroundColor DarkGray
        docker run --rm "${IMAGE_NAME}:${TargetVersion}"
        Write-Host ("=" * 80) -ForegroundColor DarkGray
    }
}

Write-Host ""
Write-Success "Rollback script finalizado exitosamente ✨"
Write-Host ""
