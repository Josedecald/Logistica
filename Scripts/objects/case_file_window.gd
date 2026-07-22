extends Control
class_name CaseFileWindow

@onready var nombre_label: Label = $CenterContainer/PanelContainer/VBoxContainer/NombreLabel
@onready var edad_label: Label = $CenterContainer/PanelContainer/VBoxContainer/EdadLabel
@onready var profesion_label: Label = $CenterContainer/PanelContainer/VBoxContainer/ProfesionLabel
@onready var causa_label: Label = $CenterContainer/PanelContainer/VBoxContainer/CausaLabel

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

	_fill_list(incidentes_list, case_file.incidentes)
	_fill_list(atenuantes_list, case_file.atenuantes)
	_fill_list(agravantes_list, case_file.agravantes)

	visible = true

func _fill_list(container: VBoxContainer, items: Array[String]) -> void:
	for child in container.get_children():
		child.queue_free()
	for item in items:
		var label := Label.new()
		label.text = "• %s" % item
		container.add_child(label)

func _on_close_pressed() -> void:
	visible = false
