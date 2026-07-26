extends Button
class_name SoulContainer

signal selected(container: SoulContainer)

var case_file
var container_id := ""
var state
var is_selected := false

var current_cell: StorageCell = null

@onready var state_overlay: ColorRect = $StateOverlay

func _ready() -> void:
	state_overlay.visible = false
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	set_selected(!is_selected)
	selected.emit(self)

func set_selected(value: bool) -> void:
	is_selected = value
	state_overlay.visible = is_selected
	state_overlay.color = Color(1, 1, 0, 0.35)

func _get_drag_data(_at_position: Vector2):
	var preview := duplicate() as Control
	preview.modulate.a = 0.6
	preview.position = -preview.size / 2.0
	set_drag_preview(preview)
	modulate.a = 0.0
	return self

func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and is_instance_valid(self):
		modulate.a = 1.0
