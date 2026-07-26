extends Panel
class_name StorageCell

signal container_drop_requested(container: SoulContainer, cell: StorageCell)

var current_item: SoulContainer = null
var bloqueada := false

signal informacion_revelada(container: SoulContainer)

const TIEMPO_REVELACION := 15.0
var tiempo_en_celda := 0.0

@onready var progress_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	# El alma se añade después como hija de esta celda; mantenemos el indicador por encima.
	progress_bar.z_index = 10
	progress_bar.mouse_filter = Control.MOUSE_FILTER_IGNORE
	progress_bar.visible = false

func _process(delta: float) -> void:
	if current_item and not current_item.case_file.modificadores_ocultos.is_empty():
		tiempo_en_celda += delta
		progress_bar.visible = true
		progress_bar.value = (tiempo_en_celda / TIEMPO_REVELACION) * 100.0
		if tiempo_en_celda >= TIEMPO_REVELACION:
			current_item.case_file.revelar_ocultos()
			informacion_revelada.emit(current_item)
			tiempo_en_celda = 0.0
			progress_bar.visible = false
	else:
		progress_bar.visible = false

func set_bloqueada(valor: bool) -> void:
	bloqueada = valor
	modulate = Color(0.4, 0.4, 0.4, 1.0) if bloqueada else Color(1, 1, 1, 1.0)

func _can_drop_data(_at_position: Vector2, data) -> bool:
	return not bloqueada and data is SoulContainer and current_item == null

func _drop_data(_at_position: Vector2, data) -> void:
	container_drop_requested.emit(data, self)

func place_container(container: SoulContainer) -> void:
	current_item = container
	container.current_cell = self
	container.reparent(self)
	container.position = (size - container.size) / 2.0
	tiempo_en_celda = 0.0
	progress_bar.visible = false

func vacate() -> void:
	current_item = null
	tiempo_en_celda = 0.0
	progress_bar.visible = false
