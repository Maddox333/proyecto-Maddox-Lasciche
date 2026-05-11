# 06 — Técnicas de Elicitación de Requisitos

## Técnicas Utilizadas

### 1. Entrevistas
**Descripción:** Se realizaron entrevistas informales a estudiantes de primer semestre
de la Corporación Universitaria Remington para identificar las principales dificultades
al localizar aulas dentro del campus.

**Hallazgos clave:**
- El 80% de los estudiantes nuevos tardó más de 10 minutos en encontrar su primera aula
- La mayoría recurre a preguntar a otros estudiantes o personal de seguridad
- Se desconoce la distribución de torres y pisos

**Requisitos derivados:** RF1, RF9, RF10, RF11, RF13

---

### 2. Observación Directa
**Descripción:** Se observó el comportamiento de estudiantes durante los primeros
días de semestre en el campus, identificando puntos de confusión y flujos de
desplazamiento más comunes.

**Hallazgos clave:**
- Las zonas de mayor confusión son los cruces entre torres
- Los estudiantes buscan referencias visuales (colores, números de piso)
- Los cambios de aula de último momento generan caos

**Requisitos derivados:** RF9, RF10, RF14, RF15

---

### 3. Análisis de Documentos
**Descripción:** Se analizaron los documentos institucionales disponibles:
horarios académicos, planos del campus y reglamento estudiantil.

**Hallazgos clave:**
- Los horarios están disponibles en formato PDF sin vinculación a ubicación física
- Los planos del campus son estáticos y no están digitalizados
- No existe un sistema de notificación oficial ante cambios de aula

**Requisitos derivados:** RF4, RF5, RF6, RF8, RF17

---

### 4. Casos de Uso (Escenarios)
**Descripción:** Se construyeron escenarios de uso basados en situaciones reales
del estudiante para identificar flujos principales y alternativos del sistema.

**Escenarios modelados:**
- CU-01: Consultar mapa y calcular ruta hacia un aula
- CU-02: Buscar aula por nombre de materia o docente
- CU-03: Recibir notificación de cambio de aula
- CU-04: Reportar fallo técnico del sistema

**Requisitos derivados:** RF1, RF8, RF11, RF13, RF15, RF31

---

### 5. Prototipado
**Descripción:** Se elaboraron wireframes de baja fidelidad para validar con
usuarios potenciales la estructura de navegación y disposición de elementos
en las pantallas principales.

**Hallazgos clave:**
- Los usuarios prefieren acceso al mapa en máximo 2 clics desde el inicio
- El botón de calcular ruta debe ser prominente en la vista de detalle de aula
- El historial de consultas es valorado como funcionalidad secundaria

**Requisitos derivados:** RF9, RF13, RNF2, RF22