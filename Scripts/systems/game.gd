extends Control

var selected_container: SoulContainer = null
@onready var clock_label: Label = $HUD/ClockLabel
@onready var conveyor: Conveyor = $World/Conveyor
@onready var gates: Control = $World/Gates
@onready var windows: Control = $Windows
@onready var storage: Storage = $World/Storage

@onready var manual_button: Button = $HUD/ManualButton
var manual_window: ManualWindow

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
	
	var manual_window_scene := preload("res://scenes/ui/manual_window.tscn")
	manual_window = manual_window_scene.instantiate()
	windows.add_child(manual_window)
	manual_button.pressed.connect(manual_window.mostrar)
	
	DayManager.iniciar_jornada()
	for gate in gates.get_children():
		if gate is Gate:
			gate.actualizar_cuota(0, DayManager.cuotas[gate.destino])

func _process(_delta: float) -> void:
	clock_label.text = "DÍA %d - %s   %s" % [DayManager.dia_actual, DayManager.turno_texto(), DayManager.hora_actual_texto()]

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
	var regla := ClassificationManager.regla_aplicada(container.case_file)
	var acierto := regla != null and gate.destino == regla.destino
	var nivel := regla.nivel if regla else Rule.Nivel.FACIL

	DayManager.registrar_envio(gate.destino, acierto, nivel)
	gate.actualizar_cuota(DayManager.progreso.get(gate.destino, 0), DayManager.cuotas[gate.destino])

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
	
