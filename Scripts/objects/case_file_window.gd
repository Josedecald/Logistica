extends Control
class_name CaseFileWindow

signal cerrado

@onready var nombre_label: Label = $CenterContainer/PanelContainer/VBoxContainer/NombreLabel
@onready var edad_label: Label = $CenterContainer/PanelContainer/VBoxContainer/EdadLabel
@onready var profesion_label: Label = $CenterContainer/PanelContainer/VBoxContainer/ProfesionLabel
@onready var causa_label: Label = $CenterContainer/PanelContainer/VBoxContainer/CausaLabel
@onready var revision_label: Label = $CenterContainer/PanelContainer/VBoxContainer/RevisionLabel

@onready var incidentes_list: VBoxContainer = $CenterContainer/PanelContainer/VBoxContainer/IncidentesList
@onready var atenuantes_list: VBoxContainer = $CenterContainer/PanelContainer/VBoxContainer/AtenuantesList
@onready var agravantes_list: VBoxContainer = $CenterContainer/PanelContainer/VBoxContainer/AgravantesList

@onready var close_button: Button = $CenterContainer/PanelContainer/VBoxContainer/CloseButton

func _ready() -> void:
	visible = false
	close_button.pressed.connect(_on_close_pressed)

func show_case_file(case_file: CaseFile) -> void:
	nombre_label.text = "Nombre: %s" % case_file.nombre
	edad_label.text = "Edad: %d" % case_file.edad
	profesion_label.text = "Profesión: %s" % case_file.profesion
	causa_label.text = "Causa de defunción: %s" % case_file.causa_defuncion
	revision_label.visible = not case_file.modificadores_ocultos.is_empty()
	if revision_label.visible:
		revision_label.text = "ANEXO SELLADO: requiere 15 s de custodia en almacén para su revisión."

	var atenuantes := case_file.modificadores.filter(
		func(m: Modificador): return m.tipo == Modificador.Tipo.ATENUANTE
	)
	var agravantes := case_file.modificadores.filter(
		func(m: Modificador): return m.tipo == Modificador.Tipo.AGRAVANTE
	)

	_fill_list(incidentes_list, case_file.incidentes, _texto_incidente)
	_fill_list(atenuantes_list, atenuantes, func(m: Modificador): return m.texto)
	_fill_list(agravantes_list, agravantes, func(m: Modificador): return m.texto)

	visible = true

func _fill_list(container: VBoxContainer, items: Array, texto_fn: Callable) -> void:
	for child in container.get_children():
		child.queue_free()
	for item in items:
		var label := Label.new()
		label.text = "• %s" % texto_fn.call(item)
		container.add_child(label)

func _texto_incidente(incidente: Incidente) -> String:
	if incidente.cantidad_registros <= 1:
		return incidente.texto
	return "%s (%d registros)" % [incidente.texto, incidente.cantidad_registros]


func _on_close_pressed() -> void:
	visible = false
	cerrado.emit()
