extends Button
class_name SoulContainer

signal selected(container: SoulContainer)

var case_file
var container_id := ""
var state
var is_selected := false

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
