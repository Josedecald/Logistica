extends Resource
class_name Rule

enum Nivel { FACIL, MEDIO, ESPECIFICO }

@export var nivel: Nivel = Nivel.FACIL
@export var destino: Gate.Destino
@export var descripcion: String  # texto legible, para mostrarlo en el Manual más adelante
@export var prioridad: int = 0   # más alto = se evalúa primero

## Cada regla concreta debe sobrescribir esto.
func evaluate(_case_file: CaseFile) -> bool:
	push_error("evaluate() no implementado en: " + str(self))
	return false
