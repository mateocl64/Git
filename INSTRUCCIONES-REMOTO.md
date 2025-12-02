# 🚀 Instrucciones para Conectar con Repositorio Remoto

## Opción 1: GitHub

### Paso 1: Crear repositorio en GitHub
1. Ir a [github.com](https://github.com) e iniciar sesión
2. Clic en el botón "+" → "New repository"
3. Nombre del repositorio: `mi-primer-repo-devops`
4. Descripción: "Actividad 4.1 - Mi primer repositorio DevOps"
5. **NO** marcar "Initialize this repository with a README"
6. Clic en "Create repository"

### Paso 2: Conectar repositorio local con GitHub
```bash
# Agregar el remoto (reemplaza 'usuario' con tu nombre de usuario)
git remote add origin https://github.com/usuario/mi-primer-repo-devops.git

# Verificar que el remoto se agregó correctamente
git remote -v

# Renombrar rama a 'main' (opcional, GitHub usa 'main' por defecto)
git branch -M main

# Subir todos los commits al remoto
git push -u origin main
```

### Paso 3: Verificar
- Visita tu repositorio en GitHub
- Deberías ver todos los archivos y commits

---

## Opción 2: GitLab

### Paso 1: Crear repositorio en GitLab
1. Ir a [gitlab.com](https://gitlab.com) e iniciar sesión
2. Clic en "New project" → "Create blank project"
3. Nombre del proyecto: `mi-primer-repo-devops`
4. Descripción: "Actividad 4.1 - Mi primer repositorio DevOps"
5. **Desmarcar** "Initialize repository with a README"
6. Clic en "Create project"

### Paso 2: Conectar repositorio local con GitLab
```bash
# Agregar el remoto (reemplaza 'usuario' con tu nombre de usuario)
git remote add origin https://gitlab.com/usuario/mi-primer-repo-devops.git

# Verificar que el remoto se agregó correctamente
git remote -v

# Renombrar rama a 'main'
git branch -M main

# Subir todos los commits al remoto
git push -u origin main
```

### Paso 3: Verificar
- Visita tu proyecto en GitLab
- Deberías ver todos los archivos y commits

---

## 🔐 Autenticación

### Para GitHub (Token de Acceso Personal)
1. Ve a Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token
3. Selecciona scopes: `repo` (acceso completo)
4. Copia el token
5. Úsalo como contraseña cuando hagas `git push`

### Para GitLab (Token de Acceso Personal)
1. Ve a Preferences → Access Tokens
2. Crea un token con scope `write_repository`
3. Copia el token
4. Úsalo como contraseña cuando hagas `git push`

### Alternativa: SSH
```bash
# Generar clave SSH (si no tienes una)
ssh-keygen -t ed25519 -C "tu-email@ejemplo.com"

# Copiar la clave pública
cat ~/.ssh/id_ed25519.pub

# Agregar la clave en GitHub/GitLab en Settings → SSH Keys

# Usar URL SSH en lugar de HTTPS
git remote set-url origin git@github.com:usuario/mi-primer-repo-devops.git
# O para GitLab:
git remote set-url origin git@gitlab.com:usuario/mi-primer-repo-devops.git
```

---

## 📊 Comandos útiles después de conectar

```bash
# Ver estado de sincronización
git status

# Traer cambios del remoto
git pull origin main

# Subir cambios locales
git push origin main

# Ver remotos configurados
git remote -v

# Eliminar remoto (si te equivocaste)
git remote remove origin

# Ver información del remoto
git remote show origin
```

---

## ✅ Verificación Final

Después de hacer push, verifica que:
- [x] Todos los commits aparecen en el repositorio remoto
- [x] El archivo `.gitignore` está presente
- [x] El `README.md` se visualiza correctamente
- [x] La estructura de carpetas es correcta
- [x] Los archivos de código fuente están disponibles

---

## 🎓 Entregable de la Actividad 4.1

**Para completar la actividad, proporciona:**
1. URL del repositorio remoto (GitHub o GitLab)
2. Captura de pantalla del historial de commits
3. Este documento como evidencia de comandos utilizados

**Ejemplo de URL:**
- GitHub: `https://github.com/usuario/mi-primer-repo-devops`
- GitLab: `https://gitlab.com/usuario/mi-primer-repo-devops`

---

**¡Felicidades!** Has completado exitosamente la configuración de tu primer repositorio DevOps con Git. 🎉
