# 07 — Casos de Uso

## Actores del Sistema

| Actor | Tipo | Descripción |
|---|---|---|
| Estudiante | Principal | Usuario final que consulta mapas, rutas y horarios |
| Administrador | Gestión | Gestiona horarios, docentes y aulas |
| Asistente Virtual | Sistema externo | Responde consultas en lenguaje natural |
| Servicio de Notificaciones | Sistema externo | Entrega alertas al estudiante |

---

## CU-01 — Consultar Mapa y Calcular Ruta

**Actor principal:** Estudiante  
**Precondición:** El estudiante debe estar autenticado  
**Postcondición:** La ruta es calculada y registrada en el historial

### Flujo Principal
1. El estudiante inicia sesión con su correo institucional
2. El sistema muestra el Dashboard con su próxima clase
3. El estudiante accede al mapa interactivo
4. El sistema carga las torres y pisos del campus
5. El estudiante busca un aula por código, materia o docente
6. El sistema resalta el aula en el mapa
7. El estudiante solicita calcular la ruta
8. El sistema obtiene la ubicación actual y calcula la ruta óptima
9. El sistema muestra la ruta con tiempo y distancia estimados
10. El sistema registra la consulta en el historial automáticamente

### Flujos Alternativos
- **FA1 — Aula no encontrada:** El sistema muestra mensaje de error y sugiere búsqueda alternativa
- **FA2 — Error de geolocalización:** El sistema permite ingresar origen manualmente
- **FA3 — Error de carga del mapa:** El sistema muestra mensaje y opción de reintentar
- **FA4 — Error en cálculo de ruta:** El sistema notifica el fallo y registra el incidente

---

## CU-02 — Consultar Horario Académico

**Actor principal:** Estudiante  
**Precondición:** El estudiante debe estar autenticado  
**Postcondición:** El estudiante visualiza sus materias del día con aula y docente

### Flujo Principal
1. El estudiante accede a "Mis Materias" desde el Dashboard
2. El sistema consulta las materias asignadas al estudiante
3. El sistema muestra lista de materias con horario, docente y aula
4. El estudiante selecciona una materia
5. El sistema muestra el detalle y ofrece navegar al aula

---

## CU-03 — Recibir Notificación de Cambio de Aula

**Actor principal:** Estudiante  
**Actor secundario:** Servicio de Notificaciones  
**Precondición:** El administrador registró un cambio de aula  
**Postcondición:** El estudiante es notificado y puede navegar al nuevo aula

### Flujo Principal
1. El administrador modifica el aula de una materia en el sistema
2. El sistema detecta el cambio y genera una notificación
3. El servicio de notificaciones entrega la alerta al estudiante
4. El estudiante accede a la notificación
5. El sistema ofrece calcular ruta al nuevo aula directamente

---

## CU-04 — Reportar Fallo Técnico

**Actor principal:** Estudiante  
**Precondición:** El estudiante debe estar autenticado  
**Postcondición:** El reporte queda registrado con estado "Abierto"

### Flujo Principal
1. El estudiante accede a "Soporte Técnico"
2. El estudiante selecciona el tipo de fallo y escribe la descripción
3. El sistema registra el reporte con fecha y estado "Abierto"
4. El sistema confirma la recepción del reporte
5. El estudiante puede consultar el estado en cualquier momento

---

## CU-05 — Gestionar Aulas (Administrador)

**Actor principal:** Administrador  
**Precondición:** El administrador debe estar autenticado  
**Postcondición:** La información de aulas queda actualizada en el sistema

### Flujo Principal
1. El administrador accede al panel de administración
2. El administrador selecciona "Gestión de Aulas"
3. El sistema muestra la lista de aulas registradas
4. El administrador puede Crear / Editar / Eliminar aulas
5. El sistema confirma los cambios y actualiza el mapa

---

## Matriz de Casos de Uso vs Requisitos

| Caso de Uso | Requisitos Funcionales | Requisitos No Funcionales |
|---|---|---|
| CU-01 | RF1, RF9, RF10, RF11, RF13 | RNF2, RNF8, RNF14 |
| CU-02 | RF4, RF5, RF6, RF8 | RNF2 |
| CU-03 | RF15, RF16, RF17 | RNF9 |
| CU-04 | RF31, RF32, RF33 | RNF21 |
| CU-05 | RF admin CRUD | RNF14, RNF15 |