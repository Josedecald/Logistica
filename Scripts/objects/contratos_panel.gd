extends PanelContainer
class_name ContratosPanel

@onready var cielo_row: Label = $VBoxContainer/CieloRow
@onready var reencarnacion_row: Label = $VBoxContainer/ReencarnacionRow
@onready var infierno_row: Label = $VBoxContainer/InfiernoRow

const TEXTO_PRIORIDAD := {
	Contrato.Prioridad.NORMAL: "",
	Contrato.Prioridad.URGENTE: " ⚠ URGENTE",
	Contrato.Prioridad.CRITICO: " ‼ CRÍTICO",
}

func _ready() -> void:
	DayManager.jornada_iniciada.connect(_reconstruir_todo)
	DayManager.progreso_actualizado.connect(_actualizar_uno)
	if DayManager.activa:
		_reconstruir_todo()

func _reconstruir_todo() -> void:
	_actualizar_uno(Gate.Destino.CIELO)
	_actualizar_uno(Gate.Destino.REENCARNACION)
	_actualizar_uno(Gate.Destino.INFIERNO)

func _actualizar_uno(destino: Gate.Destino) -> void:
	var contrato: Contrato = DayManager.contratos[destino]
	var actual: int = DayManager.progreso[destino]
	var texto := "%s: %d / %d%s" % [
		Gate.Destino.keys()[destino], actual, contrato.cantidad, TEXTO_PRIORIDAD[contrato.prioridad]
	]
	match destino:
		Gate.Destino.CIELO: cielo_row.text = texto
		Gate.Destino.REENCARNACION: reencarnacion_row.text = texto
		Gate.Destino.INFIERNO: infierno_row.text = texto
