extends Control

var selected_container: SoulContainer = null
@onready var clock_label: Label = $HUD/ClockLabel
@onready var conveyor: Conveyor = $World/Conveyor
@onready var gates: Control = $World/Gates
@onready var windows: Control = $Windows
@onready var storage: Storage = $World/Storage

@onready var manual_button: Button = $HUD/ManualButton
@onready var resultado_label: Label = $HUD/ResultadoLabel
var manual_window: ManualWindow
var day_summary: DaySummaryWindow
var case_file_window: CaseFileWindow

func _ready() -> void:
	for gate in gates.get_children():
		if gate is Gate:
			gate.container_drop_requested.connect(_on_gate_drop_requested)
	conveyor.container_created.connect(_register_container)

	var case_file_window_scene := preload("res://scenes/ui/case_file_window.tscn")
	case_file_window = case_file_window_scene.instantiate()
	windows.add_child(case_file_window)
	case_file_window.cerrado.connect(_on_case_file_cerrado)

	var manual_window_scene := preload("res://scenes/ui/manual_window.tscn")
	manual_window = manual_window_scene.instantiate()
	windows.add_child(manual_window)
	manual_button.pressed.connect(manual_window.mostrar)

	var day_summary_scene := preload("res://scenes/ui/day_summary_window.tscn")
	day_summary = day_summary_scene.instantiate()
	windows.add_child(day_summary)
	day_summary.continuar_pulsado.connect(_on_continuar_pulsado)

	for cell in storage.grid.get_children():
		if cell is StorageCell:
			cell.container_drop_requested.connect(_on_storage_drop_requested)
			cell.informacion_revelada.connect(_on_informacion_revelada)

	DayManager.jornada_terminada.connect(_on_jornada_terminada)
	DayManager.jornada_iniciada.connect(_on_jornada_iniciada)
	DayManager.iniciar_jornada()

func _process(_delta: float) -> void:
	clock_label.text = "DÍA %d - %s   %s" % [DayManager.dia_actual, DayManager.turno_texto(), DayManager.hora_actual_texto()]

func _register_container(container: SoulContainer) -> void:
	container.selected.connect(_on_container_selected)

func _on_container_selected(container: SoulContainer) -> void:
	if container.current_cell == null:
		if selected_container:
			selected_container.set_selected(false)
		container.set_selected(false)
		selected_container = null
		case_file_window.visible = false
		return

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
	_mostrar_resultado_de_clasificacion(acierto, gate.destino, regla)

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

func _mostrar_resultado_de_clasificacion(acierto: bool, destino_enviado: Gate.Destino, regla: Rule) -> void:
	if regla == null:
		resultado_label.text = "Error administrativo: no se encontró una regla aplicable."
		return
	if acierto:
		resultado_label.text = "✓ Clasificación correcta\nAplicado: %s" % regla.descripcion
	else:
		resultado_label.text = "✕ Error: enviaste a %s\nCorrespondía %s\nAplicado: %s" % [Gate.Destino.keys()[destino_enviado], Gate.Destino.keys()[regla.destino], regla.descripcion]

func _on_continuar_pulsado() -> void:
	day_summary.visible = false
	DayManager.siguiente_dia()

func _on_jornada_terminada() -> void:
	var pendientes := conveyor.conveyor_queue.size()
	for container in conveyor.conveyor_queue.duplicate():
		container.queue_free()
	conveyor.conveyor_queue.clear()

	for cell in storage.grid.get_children():
		if cell is StorageCell and cell.current_item:
			pendientes += 1
			cell.current_item.queue_free()
			cell.vacate()

	DayManager.descartar_pendientes(pendientes)
	day_summary.mostrar()

func _on_jornada_iniciada() -> void:
	resultado_label.text = ""

func _on_case_file_cerrado() -> void:
	if selected_container:
		selected_container.set_selected(false)
		selected_container = null

func _on_informacion_revelada(container: SoulContainer) -> void:
	if selected_container == container:
		case_file_window.show_case_file(container.case_file)
