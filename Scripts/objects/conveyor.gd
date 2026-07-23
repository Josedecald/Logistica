extends Panel
class_name Conveyor

signal container_created(container: SoulContainer)

@export var speed := 150.0
@export var spawn_interval := 2.0
@export var container_spacing := 100.0
var elapsed := 0.0
var conveyor_queue: Array[SoulContainer] = []

@export var soul_container_scene: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var stop_point: Marker2D = $StopPoint

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	for i in conveyor_queue.size():
		var container = conveyor_queue[i]
		container.position.x -= speed * delta

		var min_x: float
		if i == 0:
			min_x = stop_point.position.x
		else:
			min_x = conveyor_queue[i - 1].position.x + container_spacing

		if container.position.x < min_x:
			container.position.x = min_x

	elapsed += delta
	while elapsed >= spawn_interval:
		if can_spawn_container():
			create_container()
			elapsed -= spawn_interval
		else:
			break

func create_container():
	if soul_container_scene:
		var new_container = soul_container_scene.instantiate() as SoulContainer
		add_child(new_container)
		conveyor_queue.append(new_container)
		new_container.position = spawn_point.position
		var test_file := CaseFile.new()
		test_file.nombre = "Carlos Mendoza"
		test_file.edad = 54
		test_file.profesion = "Alcalde"
		test_file.causa_defuncion = "Infarto"
		test_file.incidentes = ["Corrupción administrativa", "Soborno", "Malversación de fondos"]
		test_file.atenuantes = ["Colaboró con la investigación"]
		test_file.agravantes = ["Reincidencia"]
		new_container.case_file = test_file
		container_created.emit(new_container)

func can_spawn_container() -> bool:
	if conveyor_queue.is_empty():
		return true
	var spawn_x = spawn_point.position.x
	var last_container_x = conveyor_queue[-1].position.x
	var distance = spawn_x - last_container_x
	if distance > container_spacing:
		return true
	return false

func remove_container(container: SoulContainer) -> void:
	conveyor_queue.erase(container)
