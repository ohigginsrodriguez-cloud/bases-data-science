# Git workflow — flujo de trabajo real

## Regla principal
Nunca trabajar directo en `main`. Siempre crear una rama.

## Flujo completo

### 1. Antes de empezar cualquier tarea
```bash
git checkout main
git pull                        # traer cambios del equipo
git checkout -b feature/nombre # crear rama nueva
```

### 2. Mientras trabajas
```bash
git status                      # ver qué cambió
git diff                        # ver los cambios en detalle
git add archivo.py              # agregar archivo específico
git add .                       # agregar todo
git commit -m "descripción"     # guardar cambios
```

### 3. Cuando terminas la tarea
```bash
git push -u origin feature/nombre  # primera vez
git push                            # las siguientes veces
```

### 4. Merge a main
```bash
git checkout main
git merge feature/nombre
git push
git branch -d feature/nombre        # eliminar rama local
git push origin --delete feature/nombre  # eliminar rama remota
```

## Convenciones de nombres de ramas
- `feature/nombre` — nueva funcionalidad
- `fix/nombre`     — corrección de bug
- `data/nombre`    — notebooks o análisis

## Convenciones de commits
- En inglés, verbo en imperativo
- `Add ...`    — agregar algo nuevo
- `Fix ...`    — corregir algo
- `Update ...` — modificar algo existente
- `Remove ...` — eliminar algo

## Comandos útiles
```bash
git log --oneline       # historial resumido
git branch -a           # ver todas las ramas
git restore archivo.py  # deshacer cambios sin commitear
git stash               # guardar cambios temporalmente sin commitear
git stash pop           # recuperar cambios guardados con stash
```