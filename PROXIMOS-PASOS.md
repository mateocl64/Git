# 🚀 PRÓXIMOS PASOS - Conectar con GitHub

## ¡Ya casi terminas! Sigue estos pasos exactos:

### Paso 1: Crear cuenta en GitHub (si no tienes)
1. Ve a https://github.com
2. Haz clic en "Sign up"
3. Completa el registro

### Paso 2: Crear el repositorio remoto
1. Inicia sesión en GitHub
2. Haz clic en el botón **"+"** en la esquina superior derecha
3. Selecciona **"New repository"**
4. Configura así:
   - **Repository name:** `mi-primer-repo-devops`
   - **Description:** `Actividad 4.1 - Mi primer repositorio DevOps`
   - **Visibilidad:** Public (o Private, según prefieras)
   - **⚠️ NO marques "Add a README file"**
   - **⚠️ NO marques "Add .gitignore"**
   - **⚠️ NO marques "Choose a license"**
5. Haz clic en **"Create repository"**

### Paso 3: Conectar tu repositorio local
Copia estos comandos y ejecútalos en PowerShell (reemplaza `TU-USUARIO` con tu nombre de usuario de GitHub):

```powershell
# IMPORTANTE: Reemplaza TU-USUARIO con tu nombre de usuario real de GitHub
git remote add origin https://github.com/TU-USUARIO/mi-primer-repo-devops.git

# Renombrar rama a 'main' (GitHub usa 'main' por defecto)
git branch -M main

# Subir todos los commits al remoto
git push -u origin main
```

### Paso 4: Autenticación
Cuando te pida credenciales:
- **Username:** Tu nombre de usuario de GitHub
- **Password:** Tu Personal Access Token (NO tu contraseña)

#### ¿No tienes un Personal Access Token? Créalo así:
1. Ve a https://github.com/settings/tokens
2. Clic en "Generate new token" → "Generate new token (classic)"
3. Dale un nombre: `Git-Local`
4. Marca el checkbox: **`repo`** (Full control of private repositories)
5. Clic en "Generate token"
6. **⚠️ COPIA EL TOKEN INMEDIATAMENTE** (solo se muestra una vez)
7. Úsalo como contraseña cuando hagas `git push`

### Paso 5: Verificar
1. Ve a tu repositorio en GitHub: `https://github.com/TU-USUARIO/mi-primer-repo-devops`
2. Deberías ver todos tus archivos
3. Haz clic en "commits" para ver tu historial

### Paso 6: Copiar la URL para entregar
```
https://github.com/TU-USUARIO/mi-primer-repo-devops
```

---

## 🎯 COMANDO RÁPIDO (todo en uno)

Si ya tienes token y solo necesitas conectar:

```powershell
# Reemplaza TU-USUARIO con tu nombre de usuario
git remote add origin https://github.com/TU-USUARIO/mi-primer-repo-devops.git
git branch -M main
git push -u origin main
```

---

## ✅ CHECKLIST FINAL

- [ ] Cuenta de GitHub creada
- [ ] Repositorio remoto creado en GitHub
- [ ] Personal Access Token generado
- [ ] Comando `git remote add` ejecutado
- [ ] Comando `git branch -M main` ejecutado
- [ ] Comando `git push -u origin main` ejecutado exitosamente
- [ ] Verificado en GitHub que los archivos están ahí
- [ ] URL del repositorio copiada para entregar

---

## 🎓 PARA ENTREGAR LA ACTIVIDAD

Proporciona:
1. ✅ URL de tu repositorio: `https://github.com/TU-USUARIO/mi-primer-repo-devops`
2. ✅ Captura de pantalla del historial de commits en GitHub
3. ✅ Este proyecto completo

---

## ❓ PROBLEMAS COMUNES

### Error: "remote origin already exists"
```powershell
git remote remove origin
# Luego vuelve a agregar el remoto
```

### Error: "failed to push"
- Verifica que el nombre del repo sea exacto
- Asegúrate de usar el token, no la contraseña
- Verifica que no hayas inicializado el repo con README

### Error de autenticación
- Genera un nuevo Personal Access Token
- Asegúrate de marcar el scope `repo`
- Usa el token como contraseña

---

## 🎉 ¡LISTO!

Una vez completados estos pasos, tu actividad estará 100% terminada y lista para entregar.

**¡Excelente trabajo!** 🚀
