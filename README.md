# Max Token Saver Setup for Antigravity CLI

Este repositorio contiene las configuraciones, scripts y directivas necesarias para establecer un entorno de desarrollo autónomo orientado al ahorro masivo de tokens, 100% compatible con la metodología "Superpowers".

## Arquitectura de Herramientas

El entorno instala y configura las siguientes herramientas:

1. **RTK (Rust Token Killer)** ([GitHub](https://github.com/rtk-ai/rtk)): Actúa como interceptor de la salida estándar de la terminal para prevenir desbordamientos masivos de logs.
2. **Hippo Memory** ([GitHub](https://github.com/kitfunso/hippo-memory)): Sistema de bases de datos locales para manejo de contexto a largo plazo (configurado con `--budget 1500`).
3. **code-scale-mcp** ([LobeHub](https://lobehub.com/mcp/syphon1c-code-scale-mcp)): Servidor del Protocolo de Contexto de Modelos (MCP) especializado en indexación y navegación eficiente en el árbol del repositorio.
4. **context7-slim** ([Sitio Web](https://context7.com/)): Herramienta de indexación para resolución de documentación a través de Generación Aumentada por Recuperación (RAG).
5. **Bifrost / OneTool** ([Maxim AI](https://www.getmaxim.ai/bifrost)): Actúa como un Gateway de herramientas inteligente que consolida llamadas y reduce el gasto de tokens de uso de meta-herramientas.

## Uso y Configuración

### 1. Instalación Automática
Abre tu terminal en modo Administrador (PowerShell) en la raíz del proyecto y ejecuta el script de instalación. Esto intentará clonar e instalar las dependencias principales:

```powershell
.\install.ps1
```

### 2. Desinstalación (Rollback)
Si necesitas deshacer los cambios, eliminar las carpetas clonadas y paquetes instalados, ejecuta el script de reversión:

```powershell
.\rollback.ps1
```

### 3. Reglas del Agente (Ya configuradas)
Este repositorio ya incluye el archivo `.agents/AGENTS.md`. Cualquier agente CLI de Antigravity que acceda a esta carpeta leerá las directivas automáticamente y aplicará:
* **Cero código sin plan:** Generando siempre `docs/plans/current_task.md`.
* **El Protocolo de Quiebre (Handoff):** Interrumpiendo la ejecución para pedir limpieza de contexto (`/clear`) antes de implementar.

---
*Mantenido para el stack de Antigravity CLI. Modifica `mcp-config.json` para ajustar las políticas del Gateway.*
