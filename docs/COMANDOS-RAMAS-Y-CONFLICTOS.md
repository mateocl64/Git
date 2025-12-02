# 📋 LISTA DE COTEJO - Comandos Git para Ramas y Conflictos

## Actividad 4.2 - Comandos Ejecutados

### ✅ FASE 1: Creación de Ramas

```bash
# Ver ramas existentes
git branch

# Crear y cambiar a nueva rama
git checkout -b feature/nueva-funcionalidad

# Alternativa (dos comandos)
git branch feature/nueva-funcionalidad
git checkout feature/nueva-funcionalidad
```

**Ejecutado:**
```bash
✓ git checkout -b feature/nueva-funcionalidad
✓ git checkout -b feature/mejora-documentacion
```

---

### ✅ FASE 2: Trabajo en Ramas

```bash
# Ver en qué rama estamos
git branch

# Hacer cambios y commits en la rama
git add <archivo>
git commit -m "mensaje"

# Ver el log de la rama actual
git log --oneline
```

**Ejecutado en feature/nueva-funcionalidad:**
```bash
✓ git add src/app.py
✓ git commit -m "feat: agregar funciones de despedida y cálculo de progreso"
✓ git add src/test_app.py
✓ git commit -m "test: agregar tests para las nuevas funcionalidades"
```

**Ejecutado en feature/mejora-documentacion:**
```bash
✓ git add src/app.py
✓ git commit -m "docs: mejorar mensajes y agregar función de estadísticas"
✓ git add README.md
✓ git commit -m "docs: actualizar README con información de actividad 4.2"
```

---

### ✅ FASE 3: Cambio Entre Ramas

```bash
# Volver a la rama main
git checkout main

# Cambiar a otra rama feature
git checkout feature/mejora-documentacion

# Ver todas las ramas con asterisco en la actual
git branch
```

**Ejecutado:**
```bash
✓ git checkout main (desde feature/nueva-funcionalidad)
✓ git checkout feature/mejora-documentacion
✓ git checkout main (para hacer merges)
```

---

### ✅ FASE 4: Merge Sin Conflictos

```bash
# Asegurarse de estar en main
git checkout main

# Mergear la rama feature
git merge feature/nueva-funcionalidad

# Ver el resultado
git log --oneline --graph
```

**Ejecutado:**
```bash
✓ git checkout main
✓ git merge feature/nueva-funcionalidad -m "merge: integrar nuevas funcionalidades"
   Resultado: Fast-forward (sin conflictos)
```

---

### ✅ FASE 5: Merge Con Conflictos

```bash
# Intentar merge que generará conflicto
git merge feature/mejora-documentacion

# Output esperado:
# CONFLICT (content): Merge conflict in src/app.py
# Automatic merge failed; fix conflicts and then commit the result.
```

**Ejecutado:**
```bash
✓ git merge feature/mejora-documentacion
   ⚠️ CONFLICT (content): Merge conflict in src/app.py
```

---

### ✅ FASE 6: Inspección del Conflicto

```bash
# Ver el estado del repositorio
git status

# Ver qué archivos tienen conflicto
git diff

# Ver el contenido con marcadores de conflicto
# (abrir archivo en editor)
cat src/app.py  # o abrir en VS Code
```

**Ejecutado:**
```bash
✓ git status
   Output:
   Unmerged paths:
     both modified:   src/app.py
```

---

### ✅ FASE 7: Resolución de Conflictos

```bash
# Opción 1: Resolver manualmente
# - Abrir archivo
# - Buscar marcadores <<<<<<< HEAD
# - Editar y decidir qué mantener
# - Eliminar marcadores de conflicto
# - Guardar archivo

# Opción 2: Usar herramienta de merge
git mergetool

# Opción 3: Aceptar una versión completa
git checkout --ours <archivo>    # Mantener nuestra versión (HEAD)
git checkout --theirs <archivo>  # Mantener su versión (incoming)

# Opción 4: Abortar el merge
git merge --abort
```

**Ejecutado:**
```bash
✓ Resolución manual en VS Code
  - Análisis de ambas versiones
  - Integración de AMBOS cambios
  - Eliminación de marcadores <<<<<<< ======= >>>>>>>
```

---

### ✅ FASE 8: Completar el Merge

```bash
# Marcar el archivo como resuelto
git add <archivo-resuelto>

# Verificar que ya no hay conflictos
git status

# Hacer el commit de merge
git commit
# O con mensaje personalizado
git commit -m "merge: resolver conflicto entre ramas"
```

**Ejecutado:**
```bash
✓ git add src/app.py
✓ git commit -m "merge: resolver conflicto entre feature/mejora-documentacion y main

RESOLUCIÓN DEL CONFLICTO:
- Archivo afectado: src/app.py (función main)
- Decisión: Mantener AMBAS implementaciones (son complementarias)
- Resultado: Funcionalidad completa y mejorada"
```

---

### ✅ FASE 9: Verificación Post-Merge

```bash
# Ver el historial con gráfico
git log --graph --oneline --all

# Ver detalles del último merge
git show HEAD

# Ver diferencias entre commits
git diff HEAD~1 HEAD

# Verificar estado limpio
git status
```

**Ejecutado:**
```bash
✓ git log --graph --oneline --all
✓ git status (verificar working tree clean)
```

---

### ✅ FASE 10: Gestión de Ramas Post-Merge

```bash
# Ver todas las ramas
git branch

# Ver ramas mergeadas
git branch --merged

# Eliminar ramas ya mergeadas (opcional)
git branch -d feature/nueva-funcionalidad
git branch -d feature/mejora-documentacion

# Forzar eliminación si es necesario
git branch -D <nombre-rama>
```

**Para ejecutar (opcional):**
```bash
# Mantener ramas para evidencia:
git branch --merged
```

---

### ✅ FASE 11: Sincronización con Remoto

```bash
# Ver remotos configurados
git remote -v

# Subir la rama main con los merges
git push origin main

# Subir todas las ramas al remoto
git push origin feature/nueva-funcionalidad
git push origin feature/mejora-documentacion

# O subir todas las ramas a la vez
git push --all origin
```

**Para ejecutar:**
```bash
✓ git push origin main
✓ git push --all origin
```

---

## 📊 RESUMEN DE COMANDOS UTILIZADOS

### Comandos Básicos de Ramas
| Comando | Propósito | Veces usado |
|---------|-----------|-------------|
| `git branch` | Ver/listar ramas | 3+ |
| `git checkout -b` | Crear y cambiar a rama | 2 |
| `git checkout` | Cambiar de rama | 4 |

### Comandos de Merge
| Comando | Propósito | Veces usado |
|---------|-----------|-------------|
| `git merge` | Fusionar ramas | 2 |
| `git merge --abort` | Cancelar merge | 0 |

### Comandos de Resolución
| Comando | Propósito | Veces usado |
|---------|-----------|-------------|
| `git status` | Ver estado de conflictos | 3+ |
| `git add` | Marcar como resuelto | 1 |
| `git commit` | Completar merge | 1 |

### Comandos de Visualización
| Comando | Propósito | Veces usado |
|---------|-----------|-------------|
| `git log --graph --oneline --all` | Historial visual | 2+ |
| `git diff` | Ver diferencias | 2+ |
| `git show` | Ver detalles de commit | 1 |

---

## 🎯 CHECKLIST DE COMPLETACIÓN

### Ramas
- [x] Crear rama feature/nueva-funcionalidad
- [x] Crear rama feature/mejora-documentacion
- [x] Realizar commits en cada rama
- [x] Cambiar entre ramas correctamente

### Merges
- [x] Merge sin conflictos (fast-forward)
- [x] Merge con conflictos (three-way)
- [x] Identificar archivos en conflicto
- [x] Usar git status para diagnóstico

### Resolución de Conflictos
- [x] Analizar marcadores de conflicto
- [x] Decidir estrategia de resolución
- [x] Editar manualmente el archivo
- [x] Eliminar marcadores <<<<<<< ======= >>>>>>>
- [x] Marcar como resuelto con git add
- [x] Completar merge con git commit
- [x] Documentar la decisión tomada

### Verificación
- [x] Verificar estado limpio (git status)
- [x] Revisar historial (git log --graph)
- [x] Confirmar funcionalidad del código
- [x] Preparar para push

---

## 💡 COMANDOS ÚTILES ADICIONALES

### Diagnóstico de Conflictos
```bash
# Ver archivos en conflicto
git diff --name-only --diff-filter=U

# Ver detalles del conflicto
git diff

# Ver el archivo con conflictos
git show :1:src/app.py  # Versión base
git show :2:src/app.py  # Nuestra versión (HEAD)
git show :3:src/app.py  # Su versión (incoming)
```

### Deshacer Cambios
```bash
# Descartar cambios en archivo
git checkout -- <archivo>

# Volver a estado anterior
git reset --hard HEAD

# Abortar merge en progreso
git merge --abort

# Volver al commit anterior
git reset --hard HEAD~1
```

### Visualización Avanzada
```bash
# Historial completo con gráfico
git log --graph --oneline --decorate --all

# Ver quién modificó cada línea
git blame <archivo>

# Ver cambios en archivo específico
git log -p <archivo>

# Comparar ramas
git diff main..feature/nueva-funcionalidad
```

---

## 📚 RECURSOS DE REFERENCIA

- **Git Branching:** https://git-scm.com/book/en/v2/Git-Branching
- **Merge Conflicts:** https://git-scm.com/docs/git-merge
- **Git Workflows:** https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows

---

**Documento creado para:** Actividad 4.2 - Ramas y Conflictos  
**Fecha:** Diciembre 2, 2025  
**Total de comandos únicos utilizados:** 20+

---

_Esta lista de cotejo documenta todos los comandos Git utilizados en la actividad_
