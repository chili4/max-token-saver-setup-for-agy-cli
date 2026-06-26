# Max Token Saver Setup for Antigravity CLI

Este repositorio contiene las configuraciones, scripts y directivas necesarias para establecer un entorno de desarrollo autónomo orientado al ahorro masivo de tokens, 100% compatible con la metodología "Superpowers".

## 📦 Estado de Instalación Actual

Tras ejecutar el script `install.ps1`, tu entorno tiene el siguiente estado:

**Instalado y Descargado Automáticamente:**
* **RTK (Rust Token Killer)**: Se descarga el binario precompilado oficial y se instala en el PATH de tu sistema (`C:\Users\tu_usuario\.cargo\bin` o `System32`). No requiere compilación.
* **Hippo Memory**: Clonado en la carpeta `/hippo-memory`. Las dependencias de Node.js se instalan automáticamente.
* **Bifrost (Maxim AI)**: Instalado localmente como Gateway en tu carpeta de configuración global de Antigravity (`~/.gemini/config/bifrost`).
* **Gateway mcp-config**: Se crea el archivo `mcp-config.json` apuntando a Bifrost.
* **Directivas de Agente**: El archivo `.agents/AGENTS.md` está activo para forzar a Antigravity a usar el "Protocolo de Quiebre".

**Requiere Acción Manual (Context7 SaaS):**
* **context7-slim**: Es un servicio en la nube al que Antigravity enviará consultas de forma remota para no usar tu CPU. Debes registrarte en https://context7.com/ para obtener tu API Key.

---

## 🛠️ Requisitos del Sistema

Para que este stack funcione correctamente, asegúrate de tener:
1. **Node.js** (v18 o superior) y **NPM** instalado.
2. **Rust y Cargo** (para compilar y usar RTK).
3. **Antigravity CLI (`agy`)** instalado y autenticado en tu terminal.
4. **Claves de API** para Context7 y Maxim AI (Bifrost).

---

### Paso 1: Instalar los Motores Base (Node.js)
Para que el script funcione, necesitas tener Node.js instalado (para Hippo Memory y Bifrost). Si aún no lo tienes, descárgalo e instálalo desde [nodejs.org](https://nodejs.org/).

### Paso 2: Crear el Archivo de Configuración (.env)
Este proyecto automatizará todo el trabajo pesado. Solo necesitas decirle a Antigravity cuál es tu llave de acceso a Context7.
1. Ve a [https://context7.com/](https://context7.com/) y regístrate para obtener tu API Key.
2. En la raíz de este proyecto, haz una copia del archivo `.env.example` y llámalo `.env`.
3. Pega tu API Key dentro del archivo `.env`.

### Paso 3: Ejecutar la Instalación Automática
Abre una terminal de PowerShell como Administrador en la carpeta de este proyecto y ejecuta:
```powershell
.\install.ps1
```
¡El script se encargará del resto! Descargará los binarios precompilados de RTK, instalará Bifrost localmente, configurará el Gateway y desplegará las reglas de la directiva Superpowers en la raíz global de tu sistema Antigravity.

## 🚀 Cómo Activarlo y Usarlo Globalmente en Antigravity CLI (`agy`)

Una vez completados los requisitos y la instalación, este stack se activará para **TODOS** los proyectos de tu computadora.

### Paso 1: Configurar las Variables de Entorno (Credenciales SaaS)
Antes de correr el script de instalación, simplemente copia el archivo `.env.example`, renómbralo a `.env` y coloca ahí tus credenciales:
```env
CONTEXT7_API_KEY="tu_clave_de_context7"
```
Al ejecutar `.\install.ps1`, el script detectará tu `.env` y lo instalará en la raíz global de Antigravity junto con el resto de configuraciones (`AGENTS.md` y `mcp-config.json`).

### Paso 2: Ejecutar los Demonios en Segundo Plano
Para que la memoria a largo plazo y la intercepción de salida funcionen:
* Para Hippo Memory: Entra a `hippo-memory/` y ejecuta su comando de inicio (ej. `npm start`).
* Para RTK: Ya está en tu PATH global, asegúrate de que esté configurado para interceptar la salida.

### Paso 3: Iniciar la sesión de Antigravity CLI
Abre tu terminal en **cualquier** proyecto o carpeta de tu PC y lanza el agente:
```powershell
agy
```

**¿Qué sucederá automáticamente en toda tu máquina?**
1. **Detección de Reglas Globales:** `agy` detectará tu configuración global. El agente se comportará diferente en cualquier proyecto: no generará código hasta que no cree un plan estructurado.
2. **Detección MCP Global:** `agy` leerá tu `mcp-config.json` global y conectará a Bifrost/Context7 sin importar dónde estés programando.
3. **El Protocolo de Quiebre:** Cuando pidas una tarea compleja, se detendrá y te entregará el texto para que uses `/clear` y ahorres tokens de forma masiva en todos tus proyectos.

---

## 🧹 Desinstalación (Rollback)

Si necesitas deshacer los cambios, eliminar las carpetas clonadas y paquetes instalados, ejecuta el script de reversión:
```powershell
.\rollback.ps1
```
