# Guía de configuración

## Valores a reemplazar en el workflow

Abre `workflows/asistente-citas-whatsapp.v2.json` y busca cada placeholder:

### Twilio

**`REEMPLAZAR_TWILIO_ACCOUNT_SID`**
- Dónde: Dashboard Twilio → Account Info → Account SID
- Formato: `ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`
- Aparece en: URLs de todos los nodos de envío de WhatsApp

**`REEMPLAZAR_TWILIO_WHATSAPP_NUMBER`**
- Dónde: Twilio → Messaging → Senders → WhatsApp Sandbox
- Formato: `+14155238886` (sandbox) o tu número aprobado
- Aparece en: campo `From` de todos los nodos HTTP de WhatsApp

### Google

**`REEMPLAZAR_GOOGLE_SHEET_ID`**
- Dónde: URL de tu Google Sheet → `docs.google.com/spreadsheets/d/`**ESTE_ID**`/edit`
- Formato: cadena larga de letras y números
- Aparece en: todos los nodos de Google Sheets

**`REEMPLAZAR_GOOGLE_CALENDAR_EMAIL`**
- Dónde: el email del calendario donde están las citas
- Formato: `clinica@gmail.com`
- Aparece en: nodos de Google Calendar

### Telegram

**`REEMPLAZAR_TELEGRAM_CHAT_ID`**
- Dónde: envía un mensaje a tu bot → abre `https://api.telegram.org/bot[TOKEN]/getUpdates` → busca `"chat":{"id":`
- Formato: número entero (ej: `123456789`)
- Aparece en: nodos de notificación Telegram

### n8n

**`REEMPLAZAR_TU_DOMINIO_N8N`**
- Dónde: tu URL de n8n sin `https://`
- Formato: `mi-app.onrender.com`
- Aparece en: nodo de validación de firma Twilio

**`REEMPLAZAR_ID_ERROR_WORKFLOW`**
- Dónde: URL del navegador al editar el workflow de errores → `.../workflow/`**ESTE_ID**
- Formato: cadena alfanumérica
- Aparece en: `settings.errorWorkflow`

## IDs de credenciales

Los siguientes valores son IDs internos de n8n que se asignan automáticamente al crear las credenciales. No necesitas buscarlos manualmente — al importar el workflow y asignar cada credencial desde la UI de n8n, se actualizan solos.

- `REEMPLAZAR_CREDENTIAL_ID_GSHEETS`
- `REEMPLAZAR_CREDENTIAL_ID_GCALENDAR`
- `REEMPLAZAR_CREDENTIAL_ID_TWILIO`
- `REEMPLAZAR_CREDENTIAL_ID_TELEGRAM`
- `REEMPLAZAR_CREDENTIAL_ID_ANTHROPIC`

## Horarios de envío (ajustable)

En los nodos `Trigger 9:00` y `Trigger 8:00` puedes cambiar el cron:

```
0 9 * * 1-5   →  Lunes-viernes a las 9:00 (recordatorio 48h)
0 8 * * 1-5   →  Lunes-viernes a las 8:00 (recordatorio 2h)
```

Si tus citas son en fin de semana, cambia `1-5` por `*`.

## Horario laboral (nodo Calcular Huecos)

En el nodo `Calcular Huecos`, ajusta estas constantes a la agenda real del profesional:

```js
const HORA_INICIO = 9;       // hora de apertura
const HORA_FIN = 19;         // hora de cierre
const DIAS_LABORABLES = [1, 2, 3, 4, 5]; // 1=lunes ... 7=domingo
const DURACION_MIN = 60;     // duración por defecto en minutos
const MAX_HUECOS = 5;        // cuántas opciones ofrecer al paciente
const VENTANA_DIAS = 7;      // cuántos días hacia adelante buscar
```
