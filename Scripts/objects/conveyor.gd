extends Panel
class_name Conveyor

signal container_created(container: SoulContainer)

@export var speed := 150.0
@export var spawn_interval := 2.0
@export var gap := 20.0  # espacio visual EXTRA entre contenedores, además de su propio ancho
var elapsed := 0.0
var conveyor_queue: Array[SoulContainer] = []

@export var soul_container_scene: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var stop_point: Marker2D = $StopPoint

func _process(delta: float) -> void:
	for i in conveyor_queue.size():
		var container = conveyor_queue[i]
		container.position.x -= speed * delta

		var min_x: float
		if i == 0:
			min_x = stop_point.position.x
		else:
			var anterior = conveyor_queue[i - 1]
			min_x = anterior.position.x + anterior.size.x + gap
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
		new_container.case_file = CaseFileGenerator.generar()
		container_created.emit(new_container)

func can_spawn_container() -> bool:
	if conveyor_queue.is_empty():
		return true
	var last := conveyor_queue[-1]
	var distance = spawn_point.position.x - last.position.x
	return distance > last.size.x + gap

func remove_container(container: SoulContainer) -> void:
	conveyor_queue.erase(container)
