Documento: Backlog del MVP
Objetivo

Dividir el desarrollo del MVP en pequeñas entregas funcionales.

Cada hito debe dejar el proyecto en un estado estable y jugable.

No se comenzará una nueva fase mientras la anterior no esté terminada.

FASE 0 — Preparación del proyecto

Objetivo: Tener un proyecto limpio y listo para desarrollar.

Tareas
Crear el proyecto en Godot.
Configurar Git.
Crear la estructura de carpetas.
Crear la escena Main.
Configurar la resolución base.
Configurar Input Map.
Verificar que el proyecto inicia correctamente.
Resultado

El proyecto abre correctamente y sirve como punto de partida.

FASE 1 — Escena principal

Objetivo: Construir el espacio de trabajo.

Tareas
Crear Game.tscn.
Crear el fondo.
Crear la cinta transportadora.
Crear el almacén.
Crear los tres ductos.
Crear un HUD vacío.
Resultado

Existe la pantalla principal del juego.

Todavía no hay gameplay.

FASE 2 — Contenedores

Objetivo: Poder recibir almas.

Tareas
Crear SoulContainer.
Crear sprite temporal.
Crear movimiento por la cinta.
Generar contenedores automáticamente.
Poder seleccionarlos.
Resultado

Los contenedores aparecen y recorren la cinta continuamente.

FASE 3 — Arrastrar y soltar

Objetivo: Manipular contenedores.

Tareas
Drag & Drop.
Soltar en el almacén.
Soltar nuevamente.
Ajuste automático a la cuadrícula invisible.
Resultado

Ya es posible organizar el almacén.

El juego empieza a sentirse interactivo.

FASE 4 — Expedientes

Objetivo: Inspeccionar almas.

Tareas
Crear ventana de expediente.
Abrir con doble clic.
Mostrar información temporal.
Cerrar expediente.
Resultado

El jugador ya puede inspeccionar una alma.

FASE 5 — Manual

Objetivo: Consultar reglas.

Tareas
Crear ventana del Manual.
Mostrar reglas.
Navegar entre artículos.
Cerrar Manual.
Resultado

El ciclo principal comienza a existir.

FASE 6 — Clasificación

Objetivo: Completar el gameplay.

Tareas
Arrastrar contenedor.
Soltar en un ducto.
Detectar destino.
Confirmar envío.
Resultado

El jugador ya puede completar una clasificación.

FASE 7 — Validación

Objetivo: Saber si acertó.

Tareas
Crear ClassificationManager.
Comparar expediente.
Comparar reglas.
Resultado correcto/incorrecto.
Mostrar retroalimentación.
Resultado

Existe un juego completo.

Muy pequeño.

Pero completo.

FASE 8 — Jornada

Objetivo: Que exista un día de trabajo.

Tareas
Reloj.
Inicio.
Fin.
Detener generación de almas.
Mostrar evaluación.
Resultado

Ya existe una jornada completa.

FASE 9 — Economía

Objetivo: Recompensar al jugador.

Tareas
Calcular salario.
Bonus.
Penalizaciones.
Mostrar dinero.
Resultado

Las decisiones tienen consecuencias.

FASE 10 — Tienda

Objetivo: Comprar mejoras.

Tareas
Crear tienda.
Mostrar mejoras.
Comprar.
Aplicar efecto.
Resultado

Existe progresión.

FASE 11 — Eventos

Objetivo: Hacer que cada jornada sea distinta.

Tareas
Crear EventManager.
Calendario.
Activación.
Primer evento.

Solo uno.

Ejemplo:

Tren Infernal
Resultado

Cada jornada deja de sentirse igual.

FASE 12 — Generación real de expedientes

Objetivo: Reemplazar datos temporales.

Tareas
Crear perfiles.
Crear incidentes.
Crear circunstancias.
Crear atenuantes.
Crear agravantes.
Generar expedientes.
Resultado

Ya no existen almas "de prueba".

FASE 13 — Archivo Histórico

Objetivo: Registrar carreras.

Tareas
Crear historial.
Registrar empleado.
Guardar estadísticas.
Mostrar récords.
Resultado

Cada partida deja un legado.

FASE 14 — Despido

Objetivo: Cerrar el loop.

Tareas
Calcular rendimiento.
Detectar despido.
Mostrar resolución administrativa.
Mostrar informe final.
Volver al menú.
Resultado

El gameplay loop está completo.

FASE 15 — Primer balance

Objetivo: Encontrar el juego.

Tareas

Durante esta fase no se agrega contenido nuevo.

Solo se juega.

Y se ajusta:

velocidad de la cinta;
duración del día;
tamaño del almacén;
dificultad;
recompensas;
frecuencia de eventos.
Resultado

El juego empieza a ser divertido.

Criterios para pasar de fase

Antes de avanzar, cada fase debe cumplir cuatro condiciones:

Funciona sin errores críticos.
Puede jugarse de principio a fin dentro de su alcance.
El código es comprensible.
No requiere rehacer la fase anterior.
Qué haremos después del MVP

Solo cuando el MVP funcione empezaremos a añadir contenido:

nuevos perfiles;
nuevas reglas;
nuevos eventos;
nuevos incidentes;
nuevos modificadores;
mejoras adicionales.

En ningún caso añadiremos contenido antes de validar que el núcleo del juego es entretenido.
