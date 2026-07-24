extends Control
class_name ManualWindow

@onready var rules_list: VBoxContainer = $CenterContainer/PanelContainer/VBoxContainer/ScrollContainer/RuleList
@onready var close_button: Button = $CenterContainer/PanelContainer/VBoxContainer/Button

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_pressed)

func mostrar() -> void:
	_llenar_lista()
	visible = true

func _llenar_lista() -> void:
	for child in rules_list.get_children():
		child.queue_free()

	print("Total de reglas cargadas: ", ClassificationManager.reglas.size())
	print("Niveles activos: ", ClassificationManager.niveles_activos)

	var reglas_visibles := ClassificationManager.reglas.filter(
		func(r: Rule): return r.nivel in ClassificationManager.niveles_activos
	)
	
	print("Reglas visibles después del filtro: ", reglas_visibles.size())
	reglas_visibles.sort_custom(func(a, b): return a.prioridad > b.prioridad)

	if reglas_visibles.is_empty():
		var no_rules_label := Label.new()
		no_rules_label.text = "No hay reglas disponibles para los niveles activos."
		rules_list.add_child(no_rules_label)
		return

	for rule in reglas_visibles:
		var entry := Label.new()
		var destino_texto := Gate.Destino.keys()[rule.destino] if rule.destino < Gate.Destino.size() else "DESCONOCIDO"
		entry.text = "→ %s\n   Destino: %s\n" % [rule.descripcion, destino_texto]
		entry.autowrap_mode = TextServer.AUTOWRAP_WORD
		rules_list.add_child(entry)

func _on_close_pressed() -> void:
	visible = false
