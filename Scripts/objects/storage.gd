extends Panel
class_name Storage

@export var columns := 4
@export var rows := 4
@export var storage_cell_scene: PackedScene

@onready var grid: GridContainer = $GridContainer

func _ready() -> void:
	grid.columns = columns
	for i in columns * rows:
		var cell := storage_cell_scene.instantiate() as StorageCell
		grid.add_child(cell)
		cell.set_bloqueada(i >= Progreso.celdas_desbloqueadas)
