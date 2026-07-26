extends Control
class_name DaySummaryWindow

signal continuar_pulsado

@onready var titulo_label: Label = $CenterContainer/PanelContainer/VBoxContainer/TituloLabel
@onready var rendimiento_label: Label = $CenterContainer/PanelContainer/VBoxContainer/RendimientoLabel
@onready var almas_label: Label = $CenterContainer/PanelContainer/VBoxContainer/AlmasLabel
@onready var perdidas_label: Label = $CenterContainer/PanelContainer/VBoxContainer/PerdidasLabel
@onready var cuotas_label: Label = $CenterContainer/PanelContainer/VBoxContainer/CuotasLabel
@onready var monedas_label: Label = $CenterContainer/PanelContainer/VBoxContainer/MonedasLabel
@onready var continuar_button: Button = $CenterContainer/PanelContainer/VBoxContainer/ContinuarButton

func _ready() -> void:
	visible = false
	continuar_button.pressed.connect(func(): continuar_pulsado.emit())

func mostrar() -> void:
	titulo_label.text = "Día %d completado" % DayManager.dia_actual
	rendimiento_label.text = "Rendimiento: %d%%" % int(DayManager.rendimiento())
	almas_label.text = "Almas clasificadas: %d / %d" % [DayManager.aciertos, DayManager.aciertos + DayManager.errores]
	perdidas_label.text = "Almas perdidas (sin clasificar): %d" % DayManager.almas_perdidas
	monedas_label.text = "Monedas ganadas hoy: %d  (Total: %d)" % [DayManager.monedas_dia, DayManager.monedas_totales]

	var texto_cuotas := ""
	for destino in DayManager.cuotas:
		var cumplida: bool = DayManager.progreso[destino] >= DayManager.cuotas[destino]
		var estado := "✔" if cumplida else "✘"
		texto_cuotas += "%s %s: %d / %d\n" % [estado, Gate.Destino.keys()[destino], DayManager.progreso[destino], DayManager.cuotas[destino]]
	cuotas_label.text = texto_cuotas

	continuar_button.text = "Continuar al Día %d" % (DayManager.dia_actual + 1)
	visible = true
