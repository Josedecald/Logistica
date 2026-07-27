extends Control
class_name ContratoOfferWindow

signal respondido

@onready var titulo_label: Label = $CenterContainer/PanelContainer/VBoxContainer/TituloLabel
@onready var subtitulo_label: Label = $CenterContainer/PanelContainer/VBoxContainer/SubtituloLabel
@onready var objetivo_label: Label = $CenterContainer/PanelContainer/VBoxContainer/ObjetivoLabel
@onready var recompensa_label: Label = $CenterContainer/PanelContainer/VBoxContainer/RecompensaLabel
@onready var frase_label: Label = $CenterContainer/PanelContainer/VBoxContainer/FraseLabel
@onready var aceptar_button: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/AceptarButton
@onready var rechazar_button: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer/RechazarButton

var destino_actual: Gate.Destino

func _ready() -> void:
	visible = false
	aceptar_button.pressed.connect(func(): _responder(true))
	rechazar_button.pressed.connect(func(): _responder(false))

func mostrar(contrato: Contrato) -> void:
	destino_actual = contrato.destino
	titulo_label.text = "CONTRATO DE %s" % Gate.Destino.keys()[contrato.destino]
	subtitulo_label.text = "Solicita tu cooperación en una tarea especial."
	objetivo_label.text = contrato.texto_objetivo
	recompensa_label.text = "+%d Monedas de Ánima" % contrato.recompensa
	frase_label.text = "\"%s\"" % contrato.frase
	visible = true

func _responder(aceptado: bool) -> void:
	DayManager.responder_contrato(destino_actual, aceptado)
	visible = false
	respondido.emit()
