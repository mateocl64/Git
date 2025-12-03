# 📋 Checklist de Despliegue - Actividad 6.3

**Propósito:** Asegurar que todos los pasos críticos se ejecuten correctamente antes, durante y después del despliegue para minimizar riesgos y facilitar rollbacks.

**Última actualización:** 2025-12-02  
**Versión:** 1.0.0

---

## 🎯 Información General del Despliegue

| Campo | Valor |
|-------|-------|
| **Versión a Desplegar** | ___________ |
| **Fecha y Hora Planificada** | ___________ |
| **Responsable del Despliegue** | ___________ |
| **Reviewer/Aprobador** | ___________ |
| **Entorno Destino** | ☐ Testing ☐ Staging ☐ Production |
| **Tipo de Despliegue** | ☐ Nueva Feature ☐ Hotfix ☐ Rollback |
| **Ventana de Mantenimiento** | Inicio: _______ Fin: _______ |
| **Rollback Planificado** | ☐ Sí ☐ No |

---

## ✅ FASE 1: PRE-DESPLIEGUE (Antes del Despliegue)

### 1.1 Verificación de Código y Repositorio

- [ ] **Código en rama correcta**
  - Verificar que estamos en la rama `main` (producción) o rama de release
  - Comando: `git branch --show-current`
  - Estado esperado: `main` o `release/vX.X.X`

- [ ] **Sin cambios pendientes**
  - Verificar que no hay cambios sin commitear
  - Comando: `git status`
  - Estado esperado: `nothing to commit, working tree clean`

- [ ] **Pull Request aprobado**
  - Verificar que el PR tiene al menos 1 aprobación
  - Verificar que todas las conversaciones están resueltas
  - Link al PR: _______________

- [ ] **Tests pasando en CI**
  - Pipeline de CI completado exitosamente
  - Todos los tests unitarios pasando (12/12)
  - Análisis de código estático sin errores críticos
  - Link al pipeline: _______________

- [ ] **Versión etiquetada**
  - Crear tag semántico (vX.Y.Z)
  - Comando: `git tag -a vX.Y.Z -m "Release vX.Y.Z: descripción"`
  - Tag creado: _______________

### 1.2 Verificación de Dependencias

- [ ] **Dependencias actualizadas**
  - Revisar `requirements.txt` sin vulnerabilidades
  - Ejecutar: `pip check`
  - Resultado: _______________

- [ ] **Escaneo de seguridad pasando**
  - Trivy scan sin vulnerabilidades CRITICAL
  - Bandit security scan sin issues HIGH
  - Safety check sin vulnerabilidades conocidas

- [ ] **Compatibilidad de versiones**
  - Python: 3.9, 3.10, 3.11 compatibles
  - Docker: 28.x o superior
  - Docker Compose: 3.8 o superior

### 1.3 Verificación de Infraestructura

- [ ] **Docker instalado y corriendo**
  - Comando: `docker --version`
  - Versión esperada: `28.5.2` o superior
  - Estado: _______________

- [ ] **Docker Compose instalado**
  - Comando: `docker-compose --version`
  - Versión esperada: `3.8` o superior
  - Estado: _______________

- [ ] **Recursos del sistema disponibles**
  - CPU disponible: ≥ 0.5 cores
  - RAM disponible: ≥ 512MB
  - Disk space: ≥ 1GB
  - Comando: `docker system df`
  - Estado: _______________

- [ ] **Network configurada**
  - Network `devops-network` creada (se crea automáticamente)
  - Sin conflictos de puertos (8080)
  - Comando: `docker network ls`

### 1.4 Backup y Preparación de Rollback

- [ ] **Backup de versión anterior**
  - Identificar versión actual en producción
  - Tag de versión anterior: _______________
  - Imagen Docker anterior disponible: _______________

- [ ] **Plan de rollback documentado**
  - Script de rollback preparado: `scripts/rollback.ps1`
  - Tiempo estimado de rollback: ___________ minutos
  - Responsable de ejecutar rollback: _______________

- [ ] **Notificación a stakeholders**
  - Equipo técnico notificado: ☐ Sí
  - Usuarios informados (si aplica): ☐ Sí ☐ N/A
  - Canal de comunicación activo: ☐ Slack ☐ Teams ☐ Email

### 1.5 Verificación de Documentación

- [ ] **CHANGELOG actualizado**
  - Nuevas features documentadas
  - Bugfixes listados
  - Breaking changes identificados (si aplica)

- [ ] **README actualizado**
  - Versión actual reflejada
  - Badges actualizados
  - Instrucciones de instalación correctas

- [ ] **Documentación técnica disponible**
  - `ACTIVIDAD-6.2-CD-PIPELINE.md` disponible
  - `ACTIVIDAD-6.3-ROLLBACK.md` disponible
  - Runbooks actualizados

---

## 🚀 FASE 2: DURANTE EL DESPLIEGUE (Ejecución)

### 2.1 Inicio del Despliegue

- [ ] **Registrar hora de inicio**
  - Hora de inicio: _______________
  - Comando inicial ejecutado: _______________

- [ ] **Verificar ventana de mantenimiento**
  - Dentro de la ventana planificada: ☐ Sí ☐ No
  - Si no, justificación: _______________

### 2.2 Build de la Imagen Docker

- [ ] **Build exitoso**
  - Comando: `docker build -t devops-app:vX.Y.Z .`
  - Tiempo de build: ___________ segundos
  - Tamaño de imagen: ___________ MB
  - Estado: ☐ Exitoso ☐ Fallido

- [ ] **Tagging correcto**
  - Tag semántico aplicado: `devops-app:vX.Y.Z`
  - Tag latest actualizado: `devops-app:latest`
  - Tag SHA commit: `devops-app:${GITHUB_SHA}`
  - Comando: `docker images | grep devops-app`

- [ ] **Inspección de imagen**
  - Comando: `docker inspect devops-app:vX.Y.Z`
  - Usuario: `appuser` (non-root) ✓
  - Healthcheck configurado ✓
  - Exposed ports: `8080` ✓

### 2.3 Testing de la Imagen

- [ ] **Container inicia correctamente**
  - Comando: `docker run --rm devops-app:vX.Y.Z`
  - Exit code: `0` (esperado)
  - Output completo visible: ☐ Sí

- [ ] **Tests automatizados pasando**
  - Pytest ejecutado en container
  - 12/12 tests pasando
  - Coverage ≥ 85%
  - Log de tests: _______________

- [ ] **Healthcheck funcional**
  - Comando: `docker inspect --format='{{.State.Health.Status}}' ${CONTAINER_NAME}`
  - Estado esperado: `healthy`
  - Tiempo de health check: ___________ segundos

### 2.4 Security Scanning

- [ ] **Trivy scan completado**
  - Comando: `docker run --rm aquasec/trivy:latest image devops-app:vX.Y.Z`
  - Vulnerabilidades CRITICAL: ___________ (esperado: 0)
  - Vulnerabilidades HIGH: ___________ (aceptable: ≤ 5)
  - Acción si > 5 HIGH: ☐ Rollback ☐ Mitigar ☐ Aceptar riesgo

- [ ] **Permisos y seguridad básica**
  - Usuario non-root verificado: ☐ Sí
  - No secrets hardcoded: ☐ Verificado
  - Resource limits configurados: ☐ Sí

### 2.5 Despliegue con Docker Compose

- [ ] **Detener versión anterior**
  - Comando: `docker-compose down`
  - Container detenido: ☐ Sí
  - Network removida: ☐ Sí
  - Logs de versión anterior guardados: ☐ Sí

- [ ] **Levantar nueva versión**
  - Comando: `docker-compose up -d`
  - Container iniciado: ☐ Sí
  - Network creada: `devops-network` ☐ Sí
  - Estado del container: ☐ Running ☐ Exited (expected para oneshot apps)

- [ ] **Verificar logs en tiempo real**
  - Comando: `docker-compose logs -f`
  - No errores críticos: ☐ Sí
  - Application output correcto: ☐ Sí
  - Logs persistentes en `./logs/app.log`: ☐ Sí

### 2.6 Smoke Tests (Pruebas Básicas)

- [ ] **Application ejecuta completamente**
  - Saludo inicial visible: ☐ Sí
  - Cálculo de progreso (75%): ☐ Sí
  - Estadísticas del sistema: ☐ Sí
  - Despedida final: ☐ Sí
  - Exit code 0: ☐ Sí

- [ ] **Logs generados correctamente**
  - Archivo `./logs/app.log` existe: ☐ Sí
  - Timestamps correctos: ☐ Sí
  - Log levels (INFO, DEBUG): ☐ Sí
  - No errores inesperados: ☐ Sí

- [ ] **Health check pasando**
  - Comando: `docker inspect devops-app-container`
  - Status: `healthy` o `exited(0)` para oneshot
  - Health checks ejecutados: ___________ veces

---

## ✔️ FASE 3: POST-DESPLIEGUE (Después del Despliegue)

### 3.1 Verificación de Despliegue Exitoso

- [ ] **Registrar hora de finalización**
  - Hora de fin: _______________
  - Duración total del despliegue: ___________ minutos
  - Dentro de la ventana de mantenimiento: ☐ Sí ☐ No

- [ ] **Container en estado esperado**
  - Comando: `docker ps -a | grep devops-app`
  - Estado: ☐ Exited (0) para oneshot ☐ Running para long-running
  - No restarts inesperados: ☐ Sí

- [ ] **Verificar funcionalidad end-to-end**
  - Todas las funciones principales operativas
  - No errores en logs
  - Performance aceptable (tiempo de ejecución < 5s)

### 3.2 Monitoreo y Observabilidad

- [ ] **Logs accesibles**
  - GitHub Actions logs disponibles: ☐ Sí
  - Application logs en `./logs/app.log`: ☐ Sí
  - Docker logs: `docker logs devops-app-container` ☐ Sí

- [ ] **Métricas de recursos**
  - CPU usage: ___________ % (esperado: < 50%)
  - Memory usage: ___________ MB (esperado: < 512MB)
  - Disk usage: ___________ MB
  - Comando: `docker stats devops-app-container --no-stream`

- [ ] **Alertas configuradas (si aplica)**
  - Monitoring activo: ☐ Sí ☐ N/A
  - Alertas funcionando: ☐ Sí ☐ N/A
  - Dashboard actualizado: ☐ Sí ☐ N/A

### 3.3 Validación de Seguridad Post-Deploy

- [ ] **No vulnerabilidades introducidas**
  - Re-ejecutar Trivy scan post-deploy
  - Comparar con scan pre-deploy
  - Nuevas vulnerabilidades: ___________ (esperado: 0)

- [ ] **Secrets y configuración segura**
  - Env vars correctas: ☐ Sí
  - No secrets expuestos en logs: ☐ Sí
  - Permissions correctas en archivos: ☐ Sí

### 3.4 Documentación y Comunicación

- [ ] **Actualizar documentación**
  - CHANGELOG con nueva versión: ☐ Sí
  - README con badges actualizados: ☐ Sí
  - Versión en producción documentada: vX.Y.Z

- [ ] **Notificar despliegue exitoso**
  - Equipo técnico notificado: ☐ Sí
  - Usuarios informados (si aplica): ☐ Sí ☐ N/A
  - Status page actualizado: ☐ Sí ☐ N/A

- [ ] **Registrar en sistema de tracking**
  - Ticket de despliegue cerrado: #_______________
  - Hora de cierre: _______________
  - Estado: ☐ Exitoso ☐ Exitoso con issues ☐ Rollback ejecutado

### 3.5 Cleanup y Mantenimiento

- [ ] **Limpiar recursos antiguos**
  - Imágenes Docker antiguas removidas (si > 3 versiones)
  - Comando: `docker image prune -a --filter "until=168h"`
  - Containers detenidos removidos: `docker container prune`

- [ ] **Backup post-despliegue**
  - Logs guardados en repositorio central: ☐ Sí ☐ N/A
  - Configuración respaldada: ☐ Sí
  - Estado del sistema documentado: ☐ Sí

- [ ] **Preparar para próximo despliegue**
  - Lecciones aprendidas documentadas: ☐ Sí
  - Checklist actualizado si necesario: ☐ Sí
  - Plan de rollback actualizado: ☐ Sí

---

## 🚨 CRITERIOS DE ROLLBACK

**Si alguno de los siguientes criterios se cumple, ejecutar ROLLBACK inmediatamente:**

### Criterios Críticos (Rollback Obligatorio)

- [ ] **Build falla completamente**
  - Docker build retorna exit code != 0
  - Errores de sintaxis o dependencias no resueltas

- [ ] **Tests fallan > 20%**
  - Más de 2 tests de 12 fallando
  - Coverage cae por debajo de 70%

- [ ] **Vulnerabilidades CRITICAL detectadas**
  - Trivy detecta vulnerabilidades CRITICAL (score ≥ 9.0)
  - CVEs conocidos sin mitigación disponible

- [ ] **Container no inicia**
  - Container crashea en menos de 30 segundos
  - Exit code != 0 inesperado

- [ ] **Healthcheck falla consistentemente**
  - 3 intentos consecutivos de health check fallidos
  - Status: `unhealthy` por más de 2 minutos

### Criterios de Advertencia (Evaluar Rollback)

- [ ] **Performance degradada > 50%**
  - Tiempo de ejecución > 2x esperado
  - CPU usage > 80% sostenido

- [ ] **Memory leaks detectados**
  - Memory usage crece sin estabilizarse
  - OOM (Out of Memory) warnings

- [ ] **Logs con errores frecuentes**
  - > 10 errores en primeros 5 minutos
  - Errores no documentados o inesperados

- [ ] **Feedback negativo de usuarios**
  - Reportes de funcionalidad rota
  - Errores en funcionalidades core

---

## 🔄 PROCEDIMIENTO DE ROLLBACK RÁPIDO

**Si se detecta un problema crítico, seguir estos pasos:**

### 1. Detener Despliegue Actual

```powershell
# Detener container y servicios
docker-compose down

# Verificar que todo está detenido
docker ps -a | grep devops-app
```

### 2. Identificar Versión Anterior Estable

```powershell
# Listar tags de versiones
git tag -l

# Identificar última versión estable (ejemplo: v1.0.0)
echo "Rollback a versión: v1.0.0"
```

### 3. Ejecutar Script de Rollback

```powershell
# Opción A: Usar script automatizado
.\scripts\rollback.ps1 -TargetVersion "v1.0.0"

# Opción B: Manual
git checkout tags/v1.0.0
docker build -t devops-app:v1.0.0 .
docker tag devops-app:v1.0.0 devops-app:latest
docker-compose up -d
```

### 4. Verificar Rollback Exitoso

```powershell
# Verificar container corriendo
docker ps | grep devops-app

# Verificar logs
docker logs devops-app-container

# Verificar funcionalidad
docker run --rm devops-app:latest
```

### 5. Notificar Rollback

- [ ] Equipo técnico notificado del rollback
- [ ] Incident report creado: #_______________
- [ ] Post-mortem planificado para: _______________

---

## 📊 Métricas de Despliegue

**Registrar para análisis y mejora continua:**

| Métrica | Valor | Objetivo |
|---------|-------|----------|
| **Tiempo total de despliegue** | _______ min | < 15 min |
| **Tiempo de build** | _______ seg | < 120 seg |
| **Tiempo de tests** | _______ seg | < 60 seg |
| **Downtime (si aplica)** | _______ seg | 0 seg (zero-downtime) |
| **Tests pasando** | ___ / 12 | 12/12 (100%) |
| **Coverage** | _______% | ≥ 85% |
| **Vulnerabilidades CRITICAL** | _______ | 0 |
| **Vulnerabilidades HIGH** | _______ | ≤ 5 |
| **CPU usage post-deploy** | _______% | < 50% |
| **Memory usage post-deploy** | _______ MB | < 512MB |
| **Rollbacks ejecutados** | _______ | 0 (ideal) |

---

## ✅ FIRMA DE APROBACIÓN

**Completar al finalizar el despliegue:**

| Rol | Nombre | Firma | Fecha/Hora |
|-----|--------|-------|------------|
| **Desplegador** | _______________ | _______________ | _______________ |
| **Reviewer** | _______________ | _______________ | _______________ |
| **Aprobador Final** | _______________ | _______________ | _______________ |

**Estado Final del Despliegue:** ☐ Exitoso ☐ Exitoso con observaciones ☐ Rollback ejecutado

**Comentarios Finales:**
```
_______________________________________________
_______________________________________________
_______________________________________________
```

---

## 📚 Referencias

- **Pipeline de CD:** `.github/workflows/cd.yml`
- **Documentación Técnica:** `docs/ACTIVIDAD-6.2-CD-PIPELINE.md`
- **Plan de Rollback:** `docs/ACTIVIDAD-6.3-ROLLBACK.md`
- **Script de Rollback:** `scripts/rollback.ps1`
- **CHANGELOG:** `CHANGELOG.md`

---

**Versión del Checklist:** 1.0.0  
**Última Revisión:** 2025-12-02  
**Próxima Revisión:** [Después de cada despliegue - mejora continua]
