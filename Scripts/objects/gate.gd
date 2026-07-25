extends Panel
class_name Gate

enum Destino { CIELO, REENCARNACION, INFIERNO }

@export var destino: Destino = Destino.CIELO
@onready var quota_label: Label = $QuotaLabel

signal container_drop_requested(container: SoulContainer, gate: Gate)

func _can_drop_data(_at_position: Vector2, data) -> bool:
	return data is SoulContainer

func _drop_data(_at_position: Vector2, data) -> void:
	container_drop_requested.emit(data, self)

func receive_container(container: SoulContainer) -> void:
	var tween := create_tween()
	tween.tween_property(container, "modulate:a", 0.0, 0.2)
	tween.parallel().tween_property(container, "scale", Vector2(0.3, 0.3), 0.2)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.finished.connect(container.queue_free)

func actualizar_cuota(actual: int, meta: int) -> void:
	quota_label.text = "%d / %d" % [actual, meta]
