# Max Token Saver Setup for Antigravity CLI

Este repositorio contiene las configuraciones, scripts y directivas necesarias para establecer un entorno de desarrollo autónomo orientado al ahorro masivo de tokens, 100% compatible con la metodología "Superpowers".

## 📦 Estado de Instalación Actual

Tras ejecutar el script `install.ps1`, tu entorno tiene el siguiente estado:

**Instalado y Clonado Automáticamente:**
* **RTK (Rust Token Killer)**: Clonado en la carpeta `/rtk`. Requiere compilación local con `cargo`.
* **Hippo Memory**: Clonado en la carpeta `/hippo-memory`. Las dependencias de Node.js se han instalado.
* **code-scale-mcp**: Se ha intentado instalar globalmente vía NPM (`npm install -g @syphon1c/code-scale-mcp`).
* **Gateway mcp-config**: Se ha creado el archivo `mcp-config.json` en la raíz del proyecto para enrutar las peticiones.
* **Directivas de Agente**: El archivo `.agents/AGENTS.md` está activo para forzar a Antigravity a usar el "Protocolo de Quiebre".

**Requiere Acción Manual (Servicios SaaS):**
* **context7-slim**: Debes registrarte en https://context7.com/ para obtener tus credenciales.
* **Bifrost (Maxim AI)**: Debes configurar tu cuenta y API key en https://www.getmaxim.ai/bifrost.

---

## 🛠️ Requisitos del Sistema

Para que este stack funcione correctamente, asegúrate de tener:
1. **Node.js** (v18 o superior) y **NPM** instalado.
2. **Rust y Cargo** (para compilar y usar RTK).
3. **Antigravity CLI (`agy`)** instalado y autenticado en tu terminal.
4. **Claves de API** para Context7 y Maxim AI (Bifrost).

---

## 🚀 Cómo Activarlo y Usarlo en Antigravity CLI (`agy`)

Una vez completados los requisitos y la instalación, sigue estos pasos para lanzar una sesión optimizada:

### Paso 1: Configurar las Variables de Entorno (Credenciales SaaS)
Antes de iniciar `agy`, asegúrate de tener las credenciales para Bifrost y Context7 configuradas en tu terminal.
```powershell
$env:BIFROST_API_KEY="tu_clave_de_maxim"
$env:CONTEXT7_API_KEY="tu_clave_de_context7"
```

### Paso 2: Ejecutar los Demonios en Segundo Plano
Para que el Gateway y la memoria funcionen, inicia sus servidores en terminales separadas (o en segundo plano):
* Para Hippo Memory: Entra a `hippo-memory/` y ejecuta su comando de inicio (ej. `npm start`).
* Para RTK: Asegúrate de que el binario de RTK esté en tu PATH para que intercepte la salida por defecto.

### Paso 3: Iniciar la sesión de Antigravity CLI
Abre tu terminal en la raíz de este proyecto y lanza el agente:
```powershell
agy
```

**¿Qué sucederá automáticamente?**
1. **Detección de Reglas:** `agy` detectará inmediatamente el archivo `.agents/AGENTS.md`. Verás que el agente se comporta diferente: no generará código hasta que no cree un plan estructurado en `docs/plans/current_task.md`.
2. **Detección MCP:** `agy` leerá `mcp-config.json` y se conectará automáticamente a Bifrost (que a su vez enruta a `code-scale-mcp` y `context7`).
3. **El Protocolo de Quiebre:** Cuando pidas una tarea compleja, el agente escribirá el plan y **se detendrá**. Te pedirá que ejecutes `/clear`. Al hacerlo, limpiarás el historial largo de tokens, le pegarás el prompt de reinicio que te dio, y el agente continuará su trabajo consumiendo una fracción del costo habitual.

---

## 🧹 Desinstalación (Rollback)

Si necesitas deshacer los cambios, eliminar las carpetas clonadas y paquetes instalados, ejecuta el script de reversión:
```powershell
.\rollback.ps1
```
