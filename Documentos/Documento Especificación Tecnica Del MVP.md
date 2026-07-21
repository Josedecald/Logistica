Documento: Especificación Técnica del MVP
Objetivo

Traducir el diseño del juego a una estructura técnica sencilla, escalable y fácil de mantener para un desarrollador en solitario.

La prioridad no es crear una arquitectura perfecta, sino una estructura clara que permita avanzar sin tener que reorganizar el proyecto constantemente.

Cada sistema tendrá una única responsabilidad y una comunicación simple con el resto.

Filosofía

Este documento no define cómo se programa cada sistema, únicamente establece qué piezas existen.

Cuando una pieza esté terminada, no debería ser necesario modificar las demás para añadir nuevo contenido.

El contenido (perfiles, incidentes, reglas, eventos, etc.) debe vivir separado de la lógica.

Estructura del proyecto
res://

assets/
audio/
fonts/
sprites/

data/

profiles/
incidents/
rules/
events/
upgrades/

scenes/

main/

game/

ui/

systems/

objects/

autoload/

scripts/

resources/
Escenas
Main.tscn

Es la escena raíz.

Su única responsabilidad es iniciar el juego.

Game.tscn

Es la escena donde ocurre toda la partida.

Contendrá:

HUD
Cinta transportadora
Almacén
Ductos
Panel lateral
Gestores principales

Será la escena donde el jugador pasará prácticamente toda la partida.

MainMenu.tscn

Pantalla inicial.

Opciones:

Nueva partida
Archivo histórico
Opciones
Salir
Shop.tscn

Tienda entre jornadas.

Report.tscn

Informe de evaluación.

Se utiliza tanto al finalizar un día como al finalizar la partida.

Escenas de objetos
SoulContainer.tscn

Representa un contenedor.

Contiene:

sprite
icono
datos del alma
interacción
Conveyor.tscn

Cinta transportadora.

Su responsabilidad es mover contenedores.

No sabe qué contienen.

Storage.tscn

Almacén temporal.

Gestiona las posiciones disponibles.

ExitGate.tscn

Representa un destino.

Habrá tres instancias.

Cielo
Reencarnación
Infierno
Escenas UI
HUD.tscn

Información permanente.

tiempo
dinero
jornada
precisión
próximos eventos
CaseFile.tscn

Ventana del expediente.

RuleBook.tscn

Manual.

EventPanel.tscn

Eventos activos.

ShopUI.tscn

Interfaz de mejoras.

ReportUI.tscn

Resultados de la jornada.

Sistemas

Todos vivirán dentro de

systems/
DayManager.gd

Controla

inicio del día
tiempo
final
evaluación

Nunca genera expedientes.

SoulGenerator.gd

Genera un expediente.

Lee únicamente datos.

No conoce el Manual.

RuleManager.gd

Carga las reglas.

Permite consultarlas.

ClassificationManager.gd

Recibe

expediente
destino elegido

Devuelve

correcto
incorrecto

Nada más.

EventManager.gd

Gestiona

calendario
eventos
activación
finalización
EconomyManager.gd

Calcula

salario
bonus
multas
UpgradeManager.gd

Gestiona

tienda
compras
mejoras activas
StatisticsManager.gd

Guarda

récords
empleados
historial
SaveManager.gd

Guardar y cargar.

Nada más.

Recursos

Aquí aparece una decisión importante.

No quiero escribir los perfiles dentro del código.

Quiero que todo sea editable.

Por eso utilizaremos Resources de Godot.

Profile.tres

Citizen.profile

Doctor.profile

Businessman.profile

Lo mismo para los incidentes.

Bribery.incident

Fraud.incident

Murder.incident

Las reglas.

Rule001.rule

Rule002.rule

Los eventos.

HellTrain.event

Audit.event

Las mejoras.

Scanner.upgrade

ThermalFilter.upgrade

Eso permitirá ampliar el juego sin tocar código.

Flujo del juego
Main

↓

Nueva partida

↓

Game

↓

DayManager inicia jornada

↓

SoulGenerator crea expediente

↓

Conveyor recibe contenedor

↓

Jugador inspecciona

↓

RuleManager consulta reglas

↓

Jugador clasifica

↓

ClassificationManager valida

↓

EventManager dispara eventos

↓

Fin de jornada

↓

EconomyManager calcula pago

↓

Shop

↓

Nueva jornada
Dependencias

La regla será sencilla.

Los sistemas pueden hablar con los gestores.

Nunca entre ellos directamente si no es necesario.

Ejemplo

DayManager

↓

EventManager

↓

HUD

En lugar de

HUD

↓

Economy

↓

Classification

↓

Storage

↓

RuleManager

Así evitamos dependencias innecesarias.

MVP real

La primera versión jugable solo necesita que estos sistemas funcionen:

DayManager
SoulGenerator
RuleManager
ClassificationManager
EventManager
StatisticsManager

Todo lo demás puede implementarse después.

Qué NO vamos a hacer
Arquitecturas empresariales.
Patrones de diseño porque sí.
Inyección de dependencias.
ECS.
Sistemas de plugins.
Framework propio.
Abstracciones innecesarias.

