extends Panel
class_name StorageCell

signal container_drop_requested(container: SoulContainer, cell: StorageCell)

var current_item: SoulContainer = null

func _can_drop_data(_at_position: Vector2, data) -> bool:
	return data is SoulContainer and current_item == null

func _drop_data(_at_position: Vector2, data) -> void:
	container_drop_requested.emit(data, self)

func place_container(container: SoulContainer) -> void:
	current_item = container
	container.current_cell = self
	container.reparent(self)
	container.position = (size - container.size) / 2.0

func vacate() -> void:
	current_item = null
