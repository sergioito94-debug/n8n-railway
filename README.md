# Asistente de Citas por WhatsApp — n8n

Sistema de recordatorios y gestión de citas para pymes a través de WhatsApp, integrado con Google Calendar y Google Sheets.

## ¿Qué hace?

- Envía recordatorios automáticos por WhatsApp a **48h y 2h antes** de cada cita
- El paciente puede responder **SÍ / NO / CAMBIAR** directamente por WhatsApp
- La IA (Claude Haiku) clasifica la respuesta automáticamente
- Si cancela: marca el evento en Google Calendar como cancelado
- Si quiere cambiar: calcula huecos libres y ofrece opciones numeradas
- Registra todo en Google Sheets y notifica al propietario por Telegram

## Stack

- **n8n** — automatización (self-hosted)
- **Twilio** — envío y recepción de WhatsApp
- **Google Calendar** — fuente de verdad de las citas
- **Google Sheets** — registro de estados y recordatorios
- **Claude Haiku** — clasificación inteligente de respuestas
- **Telegram** — alertas al propietario

## Estructura

```
n8n-citas-pymes/
├── workflows/
│   └── asistente-citas-whatsapp.v2.json   ← importar en n8n
├── docs/
│   ├── configuracion.md                    ← valores a reemplazar
│   ├── google-sheets.md                    ← estructura de pestañas
│   └── google-calendar.md                  ← formato de eventos
├── .env.example                            ← variables de entorno
├── .gitignore
└── README.md
```

## Instalación rápida

### 1. Importar workflow en n8n
- Menú → Workflows → `+` → Import from file
- Selecciona `workflows/asistente-citas-whatsapp.v2.json`

### 2. Reemplazar valores (ver `docs/configuracion.md`)

| Placeholder | Valor |
|-------------|-------|
| `REEMPLAZAR_TWILIO_ACCOUNT_SID` | Dashboard Twilio → Account SID |
| `REEMPLAZAR_TWILIO_WHATSAPP_NUMBER` | Número Twilio WhatsApp (ej: +14155238886) |
| `REEMPLAZAR_GOOGLE_SHEET_ID` | ID de tu Google Sheet |
| `REEMPLAZAR_GOOGLE_CALENDAR_EMAIL` | Email del calendario (ej: clinica@gmail.com) |
| `REEMPLAZAR_TELEGRAM_CHAT_ID` | Tu Chat ID de Telegram |
| `REEMPLAZAR_TU_DOMINIO_N8N` | Tu dominio n8n (sin https://) |
| `REEMPLAZAR_ID_ERROR_WORKFLOW` | ID del workflow de errores en n8n |

### 3. Configurar credenciales en n8n (Settings → Credentials)

| Nombre | Tipo |
|--------|------|
| Google Sheets account | Google Sheets OAuth2 |
| Google Calendar account | Google Calendar OAuth2 |
| Twilio (HTTP Basic Auth) | Username: Account SID / Password: Auth Token |
| Telegram account | Telegram API Token |
| Anthropic API Key | HTTP Header Auth (`x-api-key`) |

### 4. Configurar Google Sheets (ver `docs/google-sheets.md`)

Necesitas 2 pestañas:
- **Hoja 1** — registro de citas y recordatorios
- **EstadosConversacion** — conversaciones en curso

### 5. Configurar Google Calendar (ver `docs/google-calendar.md`)

Cada evento debe tener en la descripción:
```
telefono: +34612345678
nombre: Nombre Paciente
```

### 6. Conectar Twilio webhook

En Twilio → WhatsApp Sandbox → When a message comes in:
```
https://tu-dominio-n8n/webhook/whatsapp-respuesta
```
Método: HTTP POST

### 7. Activar el workflow

Toggle **Active** → ON

## Flujo completo

```
[Cron 9:00] → Citas en 48h en Calendar → Filtra con teléfono
           → Envía WhatsApp recordatorio → Registra en Sheets

[Cron 8:00] → Citas en 2h en Calendar → Filtra con teléfono
           → Envía WhatsApp recordatorio → Registra en Sheets

[Paciente responde] → Webhook Twilio → Valida firma
           → Claude clasifica (CONFIRMADA/CANCELADA/CAMBIO)
           → Actúa en Calendar + Sheets + notifica Telegram
```

## Coste estimado

| Servicio | Coste |
|----------|-------|
| n8n self-hosted (Render) | 0 € |
| Twilio WhatsApp (sandbox) | 0 € en desarrollo |
| Claude Haiku | < 0,001 € por respuesta |
| Google APIs | Gratuito |
| **Total desarrollo** | **~0 €** |
