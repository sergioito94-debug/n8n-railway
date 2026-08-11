# Configuración de Google Calendar

## Formato de eventos

Para que el workflow detecte el teléfono del paciente, cada evento del calendario **debe incluir en el campo Descripción**:

```
telefono: +34612345678
nombre: Nombre Paciente
```

Ejemplo de evento completo:
- **Título:** Fisioterapia — María García
- **Descripción:**
  ```
  telefono: +34612345678
  nombre: María García
  duracion_minutos: 60
  ```
- **Fecha/hora:** la de la cita

## Notas importantes

- El prefijo del teléfono es obligatorio (`+34` para España). Si no lo incluyes, el workflow añade `+34` automáticamente.
- Si no hay teléfono en la descripción, el evento se ignora (no se envía recordatorio).
- El campo `duracion_minutos` es opcional. Si no está, se usa 60 minutos por defecto.
- Cuando una cita se cancela, el workflow renombra el evento a `❌ CANCELADA - Nombre Paciente` y lo marca en rojo en el calendario.

## Calendario usado

El workflow lee del calendario `primary` (el principal de la cuenta). Si quieres usar un calendario específico de la clínica, cambia el valor `primary` en los nodos `Citas Calendario 7d` y `Verificar Disponibilidad` por el ID del calendario correspondiente.
