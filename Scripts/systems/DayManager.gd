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
var progreso: Dictionary = {}

var monedas_totales := 0   # billetera real, persiste entre días
var monedas_dia := 0       # solo lo ganado HOY, se resetea cada jornada
var almas_perdidas := 0

func iniciar_jornada() -> void:
	tiempo_restante = DURACION_REAL
	activa = true
	cuotas.clear()
	progreso.clear()
	monedas_dia = 0
	aciertos = 0
	errores = 0
	almas_perdidas = 0
	for destino in RANGOS_CUOTA:
		var rango: Vector2i = RANGOS_CUOTA[destino]
		cuotas[destino] = randi_range(rango.x, rango.y)
		progreso[destino] = 0
	jornada_iniciada.emit()

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
		monedas_totales += monedas_dia
		jornada_terminada.emit()

func registrar_envio(destino: Gate.Destino, acierto: bool, nivel: Rule.Nivel) -> void:
	if not activa:
		return
	if acierto:
		aciertos += 1
		progreso[destino] = progreso.get(destino, 0) + 1
		monedas_dia += PAGO_BASE + BONO_POR_NIVEL.get(nivel, 0)
		if progreso[destino] == cuotas[destino]:
			monedas_dia += BONO_CUOTA_COMPLETA
			cuota_completada.emit(destino)
	else:
		errores += 1
		monedas_dia = max(0, monedas_dia - PENALIZACION_ERROR)

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
