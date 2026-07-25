extends Control
class_name ManualWindow

@onready var rules_list: VBoxContainer = $CenterContainer/PanelContainer/VBoxContainer/ScrollContainer/RuleList
@onready var close_button: Button = $CenterContainer/PanelContainer/VBoxContainer/Button

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_pressed)

func mostrar() -> void:
	print("mostrar() llamado")
	_llenar_lista()
	visible = true
	print("visible ahora es: ", visible)

func _llenar_lista() -> void:
	for child in rules_list.get_children():
		child.queue_free()

	print("Total reglas en ClassificationManager: ", ClassificationManager.reglas.size())
	print("Niveles activos: ", ClassificationManager.niveles_activos)

	var reglas_visibles := ClassificationManager.reglas.filter(
		func(r: Rule): return r.nivel in ClassificationManager.niveles_activos
	)
	print("Reglas visibles después del filtro: ", reglas_visibles.size())

	reglas_visibles.sort_custom(func(a, b): return a.prioridad > b.prioridad)

	for rule in reglas_visibles:
		var entry := Label.new()
		entry.text = "→ %s\n   Destino: %s\n" % [rule.descripcion, Gate.Destino.keys()[rule.destino]]
		entry.autowrap_mode = TextServer.AUTOWRAP_WORD
		rules_list.add_child(entry)
	print("Hijos agregados a rules_list: ", rules_list.get_child_count())

func _on_close_pressed() -> void:
	visible = false
