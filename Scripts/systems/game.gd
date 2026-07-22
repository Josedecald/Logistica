extends Control

var selected_container: SoulContainer = null

@onready var conveyor: Conveyor = $World/Conveyor
@onready var gates: Control = $World/Gates
@onready var windows: Control = $Windows

var case_file_window: CaseFileWindow

func _ready() -> void:
	for gate in gates.get_children():
		if gate is Gate:
			gate.gate_clicked.connect(_on_gate_clicked)
	conveyor.container_created.connect(_register_container)

	var case_file_window_scene := preload("res://scenes/ui/case_file_window.tscn")
	case_file_window = case_file_window_scene.instantiate()
	windows.add_child(case_file_window)

func _register_container(container: SoulContainer) -> void:
	container.selected.connect(_on_container_selected)

func _on_container_selected(container: SoulContainer) -> void:
	if selected_container and selected_container != container:
		selected_container.set_selected(false)

	if container.is_selected:
		selected_container = container
		case_file_window.show_case_file(container.case_file)
	else:
		selected_container = null

func _on_gate_clicked(destino: Gate.Destino, gate: Gate) -> void:
	if selected_container == null:
		return
	conveyor.remove_container(selected_container)
	gate.receive_container(selected_container)
	case_file_window.visible = false
	selected_container = null
