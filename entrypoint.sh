#!/bin/sh
chown -R node:node /home/node/.n8n
exec su node -c "n8n start"
