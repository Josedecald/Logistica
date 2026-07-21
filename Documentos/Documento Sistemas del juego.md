Documento: Sistemas del Juego
Objetivo

Definir todos los sistemas que compondrán el juego y cómo se relacionan entre sí.

Este documento servirá como referencia durante todo el desarrollo.

Cada sistema debe tener una única responsabilidad.

Visión general
                     PARTIDA

                        │

      ┌─────────────────┼─────────────────┐

      ▼                 ▼                 ▼

 Sistema de       Sistema de        Sistema de
 Jornadas         Expedientes       Economía

      │                 │                 │

      ▼                 ▼                 ▼

 Sistema de       Sistema de        Sistema de
 Eventos          Clasificación     Mejoras

      │                 │                 │

      └─────────────────┼─────────────────┘

                        ▼

                 Sistema de UI

                        │

                        ▼

                 Estadísticas
Sistema de Jornadas

Responsable de controlar el flujo del día.

Gestiona:

duración;
inicio;
final;
reloj;
evaluación.

Nunca decide el contenido de una jornada.

Solo controla su ciclo de vida.

Sistema de Expedientes

Genera cada alma.

Se encarga de:

elegir un perfil;
generar incidentes;
agregar circunstancias;
seleccionar atenuantes;
agregar agravantes;
construir el expediente.

No conoce las reglas del Manual.

Sistema de Clasificación

Comprueba si la decisión del jugador fue correcta.

Consulta:

expediente;
reglamento;
eventos activos.

Devuelve:

correcta;
incorrecta.

Nada más.

Sistema de Eventos

Controla todos los sucesos especiales.

Ejemplos:

llegada del tren;
auditorías;
nuevas circulares;
fallos del sistema;
saturaciones.

Todos los eventos utilizan este mismo sistema.

Sistema de Economía

Calcula:

salario;
bonificaciones;
penalizaciones.

Entrega la cantidad de Ánimas al finalizar cada jornada.

Sistema de Mejoras

Gestiona la tienda.

Permite desbloquear:

herramientas;
mejoras del almacén;
nuevas tecnologías;
automatizaciones.

No modifica directamente otros sistemas.

Cada mejora expone sus efectos y los demás sistemas los utilizan.

Sistema de UI

Gestiona toda la interfaz.

Incluye:

HUD;
expediente;
manual;
tienda;
informes;
ventanas.

Nunca contiene lógica del juego.

Sistema de Estadísticas

Guarda:

récords;
historial;
empleados;
carreras;
datos globales.

Permanece entre partidas.

Relaciones
Jornada

↓

Genera Eventos

↓

Llegan Expedientes

↓

Jugador Clasifica

↓

Clasificación responde

↓

Economía calcula recompensa

↓

Mejoras disponibles

↓

Nueva Jornada
Principios

Cada sistema debe poder responder una única pregunta.

Por ejemplo:

Sistema de Expedientes

¿Cómo se genera un expediente?

Sistema de Clasificación

¿La decisión del jugador fue correcta?

Sistema de Economía

¿Cuánto gana el empleado?

Si un sistema responde varias preguntas distintas, probablemente esté haciendo demasiado.
