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
	DayManager.contrato_respondido.connect(_actualizar_uno)

func _reconstruir_todo() -> void:
	_actualizar_uno(Gate.Destino.CIELO)
	_actualizar_uno(Gate.Destino.REENCARNACION)
	_actualizar_uno(Gate.Destino.INFIERNO)

func _actualizar_uno(destino: Gate.Destino) -> void:
	var contrato: Contrato = DayManager.contratos[destino]
	var row := _get_row(destino)
	match contrato.estado:
		Contrato.Estado.PENDIENTE:
			row.text = "%s: esperando respuesta..." % Gate.Destino.keys()[destino]
		Contrato.Estado.RECHAZADO:
			row.text = "%s: contrato rechazado" % Gate.Destino.keys()[destino]
		Contrato.Estado.ACEPTADO:
			var actual: int = DayManager.progreso[destino]
			row.text = "%s: %d / %d%s" % [Gate.Destino.keys()[destino], actual, contrato.cantidad, TEXTO_PRIORIDAD[contrato.prioridad]]

func _get_row(destino: Gate.Destino) -> Label:
	match destino:
		Gate.Destino.CIELO: return cielo_row
		Gate.Destino.REENCARNACION: return reencarnacion_row
		_: return infierno_row
