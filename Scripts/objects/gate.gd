extends Panel
class_name Gate

enum Destino { CIELO, REENCARNACION, INFIERNO }

@export var destino: Destino = Destino.CIELO

signal gate_clicked(destino: Destino, gate: Gate)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		gate_clicked.emit(destino, self)

func receive_container(container: SoulContainer) -> void:
	var tween := create_tween()
	tween.tween_property(container, "modulate:a", 0.0, 0.2)
	tween.parallel().tween_property(container, "scale", Vector2(0.3, 0.3), 0.2)
	tween.finished.connect(container.queue_free)
