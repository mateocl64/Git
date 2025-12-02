# 📋 Lista de Cotejo - Comandos Git Utilizados

## Actividad 4.1 - Mi Primer Repositorio DevOps

### ✅ Comandos Ejecutados

#### 1. Inicialización del Repositorio
```bash
# Inicializar repositorio Git
git init

# Verificar estado del repositorio
git status
```

#### 2. Configuración de Usuario
```bash
# Configurar nombre de usuario (local al repositorio)
git config user.name "Estudiante DevOps"

# Configurar email (local al repositorio)
git config user.email "estudiante@devops.local"

# Verificar configuración
git config --list
```

#### 3. Gestión de Archivos
```bash
# Agregar archivos específicos al staging area
git add .gitignore
git add README.md
git add config.json
git add src/app.py

# Alternativa: agregar todos los archivos
git add .
```

#### 4. Commits Realizados
```bash
# Commit 1: Configuración inicial
git commit -m "feat: agregar archivo .gitignore con patrones para Python y desarrollo"

# Commit 2: Documentación
git commit -m "docs: crear README.md con descripción del proyecto DevOps"

# Commit 3: Configuración
git commit -m "config: agregar archivo de configuración del proyecto"

# Commit 4: Funcionalidad principal
git commit -m "feat: implementar aplicación principal con función de saludo"

# Commit 5: Documentación de comandos
git commit -m "docs: agregar lista de comandos Git utilizados"
```

#### 5. Revisión del Historial
```bash
# Ver historial de commits
git log

# Ver historial resumido
git log --oneline

# Ver historial con gráfico
git log --graph --oneline --all
```

#### 6. Conexión con Repositorio Remoto
```bash
# Agregar repositorio remoto (GitHub)
git remote add origin https://github.com/usuario/mi-primer-repo-devops.git

# Verificar remotos configurados
git remote -v

# Subir cambios al remoto (primera vez)
git push -u origin master

# O si usas 'main' como rama principal
git branch -M main
git push -u origin main
```

#### 7. Comandos Adicionales Útiles
```bash
# Ver diferencias antes de commit
git diff

# Ver archivos en staging
git diff --staged

# Ver estado del repositorio
git status

# Ver ramas
git branch

# Crear nueva rama
git branch nombre-rama

# Cambiar de rama
git checkout nombre-rama
```

---

## 📁 Estructura del Repositorio

```
Git/
│
├── .git/                      # Directorio de Git (oculto)
│   ├── config                 # Configuración del repositorio
│   ├── HEAD                   # Referencia a la rama actual
│   ├── objects/               # Base de datos de objetos
│   └── refs/                  # Referencias a commits
│
├── .gitignore                 # Archivos a ignorar
├── README.md                  # Documentación principal
├── config.json                # Configuración del proyecto
│
├── src/                       # Código fuente
│   └── app.py                 # Aplicación principal
│
└── docs/                      # Documentación
    └── comandos-git.md        # Este archivo
```

---

## 🎯 Objetivos Cumplidos

- [x] Crear repositorio local con `git init`
- [x] Configurar `.gitignore` con patrones apropiados
- [x] Realizar commits significativos con mensajes descriptivos
- [x] Documentar comandos utilizados
- [x] Preparar para conexión con repositorio remoto

---

## 📝 Convenciones de Commits

Este proyecto utiliza commits semánticos:

- **feat:** Nueva funcionalidad
- **fix:** Corrección de errores
- **docs:** Cambios en documentación
- **config:** Cambios en configuración
- **refactor:** Refactorización de código
- **test:** Agregar o modificar tests
- **chore:** Tareas de mantenimiento

---

## 🔗 Próximos Pasos

1. Crear repositorio en GitHub o GitLab
2. Conectar repositorio local con remoto
3. Realizar push de todos los commits
4. Configurar README en el remoto
5. Agregar colaboradores (opcional)

---

## 📚 Recursos Adicionales

- [Documentación oficial de Git](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [GitLab Documentation](https://docs.gitlab.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

**Fecha de creación:** Diciembre 2, 2025  
**Actividad:** 4.1 - Mi Primer Repo DevOps  
**Autor:** Estudiante DevOps
