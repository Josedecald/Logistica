extends Control

var selected_container: SoulContainer = null

@onready var conveyor: Conveyor = $World/Conveyor
@onready var gates: Control = $World/Gates
@onready var windows: Control = $Windows
@onready var storage: Storage = $World/Storage

var case_file_window: CaseFileWindow

func _ready() -> void:
	for gate in gates.get_children():
		if gate is Gate:
			gate.container_drop_requested.connect(_on_gate_drop_requested)
	conveyor.container_created.connect(_register_container)

	for cell in storage.grid.get_children():
		if cell is StorageCell:
			cell.container_drop_requested.connect(_on_storage_drop_requested)
			
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

func _on_gate_drop_requested(container: SoulContainer, gate: Gate) -> void:
	if container.current_cell:
		container.current_cell.vacate()
	else:
		conveyor.remove_container(container)

	case_file_window.visible = false
	gate.receive_container(container)
	
func _on_storage_drop_requested(container: SoulContainer, cell: StorageCell) -> void:
	if container.current_cell:
		container.current_cell.vacate()
	else:
		conveyor.remove_container(container)
	cell.place_container(container)
