extends Control

@onready var rendimiento_label: Label = $RendimientoLabel
@onready var almas_label: Label = $AlmasLabel
@onready var errores_label: Label = $ErroresLabel
@onready var monedas_label: Label = $MonedasLabel
@onready var balance_label: Label = $BalanceLabel

func _process(_delta: float) -> void:
	rendimiento_label.text = "Rendimiento\n%d%%" % int(DayManager.rendimiento())
	almas_label.text = "Almas clasificadas\n%d / %d" % [DayManager.aciertos, DayManager.aciertos + DayManager.errores]
	errores_label.text = "Errores\n%d" % DayManager.errores
	monedas_label.text = "💀 %d" % DayManager.monedas_totales
	balance_label.text = BalanceMonitor.texto_resumen()
