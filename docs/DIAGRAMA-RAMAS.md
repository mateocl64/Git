# 🌳 Diagrama de Flujo - Actividad 4.2

## Visualización del Trabajo con Ramas y Resolución de Conflictos

```
ESTADO INICIAL
═══════════════════════════════════════════════════════════════

                    main
                     |
                     * (c132f4a) commit inicial
                     |


CREACIÓN DE RAMAS
═══════════════════════════════════════════════════════════════

                    main (c132f4a)
                     |
         ┌───────────┴───────────┐
         │                       │
  feature/nueva-         feature/mejora-
  funcionalidad          documentacion


DESARROLLO PARALELO
═══════════════════════════════════════════════════════════════

main (c132f4a)
 |
 |    feature/nueva-funcionalidad
 |    │
 |    * (aea218c) feat: agregar funciones despedida y progreso
 |    │
 |    * (084f788) test: agregar tests unitarios
 |    │
 |
 |    feature/mejora-documentacion
 |    │
 |    * (3850307) docs: mejorar mensajes y estadísticas
 |    │
 |    * (28aa3c5) docs: actualizar README


PRIMER MERGE (Sin conflictos)
═══════════════════════════════════════════════════════════════

                    main
                     |
        feature/nueva-funcionalidad
                     │
                     * (084f788) test: agregar tests
                     │
                     * (aea218c) feat: nuevas funciones
                     │
                    / \
                   /   \
                  /     \
    (c132f4a)    /       \    (084f788)
         *------*---------*   ← MERGE (Fast-forward)
              main      merged
              
✅ Resultado: Sin conflictos
   Tipo: Fast-forward
   Archivos: app.py, test_app.py


SEGUNDO MERGE (Con conflictos)
═══════════════════════════════════════════════════════════════

Estado antes del merge:

    main (084f788 - con nueva funcionalidad)
     |
     |    feature/mejora-documentacion (28aa3c5)
     |    │
     |    * docs: actualizar README
     |    │
     |    * docs: mejorar mensajes
     |    
     
Intento de merge:

     main (084f788)
       │
       │         feature/mejora-documentacion (28aa3c5)
       │                    │
       │                    │
       └────────┬───────────┘
                │
                ⚠️  CONFLICTO en src/app.py
                │
                │  Archivo: src/app.py
                │  Líneas: 71-99 (función main)
                │
                │  <<<<<<< HEAD
                │  [Versión de feature/nueva-funcionalidad]
                │  - Cálculo de progreso
                │  - Mensaje de despedida
                │  =======
                │  [Versión de feature/mejora-documentacion]
                │  - Emojis mejorados
                │  - Estadísticas del proyecto
                │  >>>>>>> feature/mejora-documentacion
                │


RESOLUCIÓN DEL CONFLICTO
═══════════════════════════════════════════════════════════════

Proceso de resolución:

1. Detectar conflicto
   │
   ├─ git status
   └─ Unmerged paths: src/app.py

2. Analizar versiones
   │
   ├─ Versión HEAD (nueva-funcionalidad):
   │    - despedir()
   │    - calcular_progreso()
   │    - Mensaje de despedida
   │
   └─ Versión incoming (mejora-documentacion):
        - obtener_estadisticas()
        - Emojis (👋, 🚀, ✅)
        - Bordes visuales

3. Decisión: INTEGRAR AMBAS
   │
   ├─ Mantener todas las funciones
   ├─ Combinar salidas
   └─ Preservar mejoras visuales

4. Edición manual
   │
   ├─ Eliminar marcadores <<<<<<< ======= >>>>>>>
   ├─ Reorganizar código
   └─ Verificar sintaxis

5. Marcar como resuelto
   │
   ├─ git add src/app.py
   └─ git commit -m "merge: resolver conflicto..."


ESTADO FINAL
═══════════════════════════════════════════════════════════════

                         main (HEAD)
                              │
                              │
    feature/nueva-       feature/mejora-
    funcionalidad        documentacion
         │                     │
         * (084f788)           * (28aa3c5)
         │                     │
         * (aea218c)           * (3850307)
         │                     │
         └────────┬────────────┘
                  │
                  │ (MERGE RESUELTO)
                  │
                  * (2b8026e) merge: resolver conflicto
                  │
                  * (084f788) merge: nueva-funcionalidad
                  │
                  * (c132f4a) estado inicial
                  │
                main (actualizado)


ESTRUCTURA DE ARCHIVOS POST-MERGE
═══════════════════════════════════════════════════════════════

src/app.py
├── saludar() ........................... [mejora-documentacion] 👋🚀
├── obtener_estadisticas() ............. [mejora-documentacion] ✅
├── despedir() ......................... [nueva-funcionalidad] ✅
├── calcular_progreso() ................ [nueva-funcionalidad] ✅
└── main()
    ├── Bordes visuales ................ [mejora-documentacion]
    ├── Emojis ......................... [mejora-documentacion]
    ├── Cálculo de progreso ............ [nueva-funcionalidad]
    ├── Estadísticas ................... [mejora-documentacion]
    └── Despedida ...................... [nueva-funcionalidad]

✅ TODAS LAS CARACTERÍSTICAS INTEGRADAS


TIMELINE COMPLETO
═══════════════════════════════════════════════════════════════

Tiempo →

│
├─ Commit inicial (c132f4a)
│   └─ Estado: 1 rama (main)
│
├─ Creación de ramas
│   ├─ feature/nueva-funcionalidad
│   └─ feature/mejora-documentacion
│
├─ Desarrollo paralelo (2 commits cada una)
│   ├─ nueva-funcionalidad: aea218c, 084f788
│   └─ mejora-documentacion: 3850307, 28aa3c5
│
├─ Merge 1: nueva-funcionalidad → main
│   ├─ Tipo: Fast-forward
│   └─ Resultado: ✅ Sin conflictos
│
├─ Merge 2: mejora-documentacion → main
│   ├─ Tipo: Three-way merge
│   ├─ Resultado: ⚠️ CONFLICTO
│   └─ Resolución: 2b8026e
│
└─ Documentación
    ├─ ACTIVIDAD-4.2-CONFLICTOS.md
    └─ COMANDOS-RAMAS-Y-CONFLICTOS.md


ESTADÍSTICAS
═══════════════════════════════════════════════════════════════

Ramas creadas:                    2
Commits en features:              4
Merges realizados:                2
Conflictos encontrados:           1
Conflictos resueltos:             1
Archivos en conflicto:            1
Líneas modificadas en conflicto:  ~30
Tiempo de resolución:             < 5 min
Tasa de éxito:                    100%


LECCIONES DEL DIAGRAMA
═══════════════════════════════════════════════════════════════

1. Las ramas permiten desarrollo paralelo
2. Los merges pueden ser automáticos (fast-forward)
3. Los conflictos ocurren en modificaciones superpuestas
4. La resolución requiere análisis y decisión
5. La documentación preserva el conocimiento


SÍMBOLOS UTILIZADOS
═══════════════════════════════════════════════════════════════

*     : Commit
│     : Línea de continuidad
┌─┐   : Bifurcación/convergencia
└─┘   : Fin de rama
→     : Dirección de flujo
✅    : Éxito/completado
⚠️     : Conflicto/advertencia
```

---

**Documento creado para:** Actividad 4.2  
**Propósito:** Visualización del flujo de trabajo con ramas  
**Fecha:** Diciembre 2, 2025

---

_Este diagrama ilustra todo el proceso de la actividad de ramas y conflictos_
