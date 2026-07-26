extends Node

signal jornada_iniciada
signal jornada_terminada

const DURACION_REAL := 480.0  # 8 minutos reales 
const HORA_INICIO := 7.0      # 7:00 am
const HORA_FIN := 17.0        # 5:00 pm

signal cuota_completada(destino: Gate.Destino)
const PAGO_BASE := 10

const BONO_POR_NIVEL := {
	Rule.Nivel.FACIL: 0,
	Rule.Nivel.MEDIO: 15,
	Rule.Nivel.ESPECIFICO: 30,
}
const PENALIZACION_ERROR := 5
const BONO_CUOTA_COMPLETA := 100

var monedas := 0
var aciertos := 0
var errores := 0

const RANGOS_CUOTA := {
	Gate.Destino.CIELO: Vector2i(8, 15),
	Gate.Destino.REENCARNACION: Vector2i(15, 25),
	Gate.Destino.INFIERNO: Vector2i(20, 35),
}

var dia_actual := 1
var tiempo_restante := DURACION_REAL
var activa := false

var cuotas: Dictionary = {}
signal progreso_actualizado(destino: Gate.Destino)
var monedas_totales := 0   # billetera real, persiste entre días
var monedas_dia := 0       # solo lo ganado HOY, se resetea cada jornada
var almas_perdidas := 0

const RANGOS_CANTIDAD := {
	Gate.Destino.CIELO: Vector2i(8, 15),
	Gate.Destino.REENCARNACION: Vector2i(15, 25),
	Gate.Destino.INFIERNO: Vector2i(20, 35),
}
const RECOMPENSA_POR_PRIORIDAD := {
	Contrato.Prioridad.NORMAL: 100,
	Contrato.Prioridad.URGENTE: 180,
	Contrato.Prioridad.CRITICO: 300,
}
const PENALIZACION_POR_PRIORIDAD := {
	Contrato.Prioridad.NORMAL: 0,
	Contrato.Prioridad.URGENTE: 50,
	Contrato.Prioridad.CRITICO: 150,
}

var contratos: Dictionary = {}   # destino -> Contrato
var progreso: Dictionary = {}    # destino -> int (sin cambios)


func iniciar_jornada() -> void:
	tiempo_restante = DURACION_REAL
	activa = true
	monedas_dia = 0
	aciertos = 0
	errores = 0
	almas_perdidas = 0
	contratos.clear()
	progreso.clear()

	for destino in RANGOS_CANTIDAD:
		var contrato := Contrato.new()
		contrato.destino = destino
		var rango: Vector2i = RANGOS_CANTIDAD[destino]
		contrato.cantidad = randi_range(rango.x, rango.y)
		contrato.prioridad = _sortear_prioridad()
		contrato.recompensa = RECOMPENSA_POR_PRIORIDAD[contrato.prioridad]
		contrato.penalizacion = PENALIZACION_POR_PRIORIDAD[contrato.prioridad]
		contratos[destino] = contrato
		progreso[destino] = 0

	jornada_iniciada.emit()


func _sortear_prioridad() -> Contrato.Prioridad:
	var r := randf()
	if r < 0.5:
		return Contrato.Prioridad.NORMAL
	elif r < 0.85:
		return Contrato.Prioridad.URGENTE
	return Contrato.Prioridad.CRITICO

func siguiente_dia() -> void:
	dia_actual += 1
	iniciar_jornada()

func _process(delta: float) -> void:
	if not activa:
		return
	tiempo_restante -= delta
	if tiempo_restante <= 0:
		tiempo_restante = 0
		activa = false
		_cerrar_contratos_incompletos()
		monedas_totales += monedas_dia
		jornada_terminada.emit()

func _cerrar_contratos_incompletos() -> void:
	for destino in contratos:
		var contrato: Contrato = contratos[destino]
		if progreso[destino] < contrato.cantidad:
			monedas_dia -= contrato.penalizacion

func registrar_envio(destino: Gate.Destino, acierto: bool, nivel: Rule.Nivel) -> void:
	if not activa:
		return
	if acierto:
		aciertos += 1
		progreso[destino] = progreso.get(destino, 0) + 1
		monedas_dia += PAGO_BASE + BONO_POR_NIVEL.get(nivel, 0)
		var contrato: Contrato = contratos[destino]
		if progreso[destino] == contrato.cantidad:
			monedas_dia += contrato.recompensa
			cuota_completada.emit(destino)
	else:
		errores += 1
		monedas_dia = max(0, monedas_dia - PENALIZACION_ERROR)
	progreso_actualizado.emit(destino)

func descartar_pendientes(cantidad: int) -> void:
	errores += cantidad
	almas_perdidas += cantidad

func rendimiento() -> float:
	var total := aciertos + errores
	if total == 0:
		return 100.0
	return (float(aciertos) / total) * 100.0

func hora_actual_texto() -> String:
	var avance := 1.0 - (tiempo_restante / DURACION_REAL)
	var hora := HORA_INICIO + avance * (HORA_FIN - HORA_INICIO)
	return "%02d:%02d" % [int(hora), int((hora - int(hora)) * 60)]

func turno_texto() -> String:
	var avance := 1.0 - (tiempo_restante / DURACION_REAL)
	var hora := HORA_INICIO + avance * (HORA_FIN - HORA_INICIO)
	return "TURNO DE MAÑANA" if hora < 12.0 else "TURNO DE TARDE"
