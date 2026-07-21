extends Button

class_name SoulContainer

var target_position: Vector2
@export var move_speed := 300.0

var case_file
var container_id := ""
var state

func _ready() -> void:
	target_position = position
	
func _process(delta: float) -> void:
	position = position.move_toward(
		target_position,
		move_speed * delta
	)
