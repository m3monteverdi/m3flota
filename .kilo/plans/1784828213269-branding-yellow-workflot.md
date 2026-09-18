# Cambio de marca a WORKFLOT y color amarillo

## Objetivo
Cambiar la identidad visual de la app:
- Nombre principal: **WORKFLOT**
- Subtítulo: **MAQUINARIAS MONTEVERDI**
- Color primario: **amarillo** (reemplazando el azul actual)

## Archivos afectados

### 1. `index.html`
- `<title>`: cambiar de `M3 Monteverdi Cubico` a `WORKFLOT`
- `.htit` (línea 21): cambiar texto de `WorkFlot` a `WORKFLOT`
- `.hsub` (línea 22): cambiar texto de `M3 Monteverdi Cubico` a `MAQUINARIAS MONTEVERDI`

### 2. `css/style.css`
Reemplazar la paleta azul (`--az`, `--azd`, `--azl`, `--azm`, `--az2`) por una paleta amarilla.
Propuesta de valores:
- `--az`: `hsl(45, 90%, 50%)` (amarillo dorado principal)
- `--azd`: `hsl(45, 90%, 40%)` (variante oscura para gradientes)
- `--azl`: `hsl(45, 80%, 96%)` (fondo claro)
- `--azm`: `hsl(45, 40%, 82%)` (bordes/medios)
- `--az2`: `hsl(35, 95%, 50%)` (acento secundario, naranja claro)

También hay que revisar los `box-shadow` con azul (`--shadow-az`) y los gradientes del header/cards que usan `var(--az)` directamente; deben quedar automáticamente por cambio de variable, pero verificar contraste.

**Validación de contraste**: header tiene fondo oscuro (será `--azd`), texto blanco. Con `hsl(45,90%,40%)` el contraste sobre blanco es bueno, sobre texto blanco también es aceptable. Si el usuario quiere header amarillo con texto negro, habría que invertir, pero el pedido es solo "cambiar el color a amarillo".

### 3. `js/app.js`
- Línea 798: cambiar `ot-logo` de `M3 Monteverdi Cubico` a `WORKFLOT`

## Consideraciones / Riesgos
- Hay caracteres con acentos en `Ã±`, `Ã¡`, etc. en `index.html`, `css/style.css` y `js/app.js`. No los tocar a menos que el usuario lo pida.
- El favicon sigue siendo `metro cubico.png`. No cambiar a menos que se solicite.

## Pasos de validación
1. Abrir la URL y confirmar que el header muestra "WORKFLOT" y "MAQUINARIAS MONTEVERDI".
2. Confirmar que la paleta general se ve amarilla (header, botones, tabs activos, badges azules actuales).
3. Confirmar que las OTs impresas/exportadas muestran "WORKFLOT" en el logo.
4. Verificar contraste de texto en header y botones.
