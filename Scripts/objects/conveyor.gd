extends Panel

class_name Conveyor

@export var speed := 150.0
@export var spawn_interval := 2.0
@export var container_spacing := 100.0
var elapsed := 0.0
var conveyor_queue: Array[SoulContainer] = []

@export var soul_container_scene: PackedScene
@onready var spawn_point: Marker2D= $SpawnPoint

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	for container in conveyor_queue:
		container.position.x -= speed * delta
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
			
func can_spawn_container() -> bool:
	
	if conveyor_queue.is_empty():
		return true
	var spawn_x = spawn_point.position.x
	var last_container_x= conveyor_queue[-1].position.x
	var distance = spawn_x - last_container_x
	if distance > container_spacing:
		return true
	return false


	
