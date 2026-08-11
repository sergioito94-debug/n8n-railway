# Estructura de Google Sheets

Crea un Google Sheet con exactamente estas 2 pestañas y columnas:

## Pestaña: Hoja 1

Registro de citas y estado de recordatorios.

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `id_cita` | texto | ID del evento en Google Calendar |
| `paciente` | texto | Nombre del paciente |
| `telefono` | texto | Teléfono con prefijo (ej: +34612345678) |
| `fecha` | texto | Fecha legible (ej: lunes, 15 de enero) |
| `hora` | texto | Hora (ej: 10:00) |
| `estado` | texto | CONFIRMADA / CANCELADA / CAMBIO / Recordatorio enviado |
| `recordatorio_enviado` | texto | 48h / 2h / vacío |

**Fila 1 debe ser la cabecera** con exactamente esos nombres.

## Pestaña: EstadosConversacion

Gestión de conversaciones en curso (cambios de hora pendientes).

| Columna | Tipo | Descripción |
|---------|------|-------------|
| `telefono` | texto | Teléfono del paciente |
| `esperando` | texto | CAMBIO_HORA u otros estados |
| `opciones` | texto | JSON con array de fechas ISO ofrecidas |
| `id_cita_original` | texto | ID del evento original en Calendar |
| `calendar_id` | texto | ID del calendario (normalmente `primary`) |
| `duracion_minutos` | número | Duración de la cita |
| `timestamp` | texto | Fecha/hora de creación del estado |

**Importante:** Esta pestaña se limpia automáticamente cuando el paciente confirma un cambio.

## Permisos necesarios

La cuenta de Google que conectes a n8n debe tener:
- Permiso de **lectura y escritura** sobre el Google Sheet
- Permiso de **lectura y escritura** sobre Google Calendar
