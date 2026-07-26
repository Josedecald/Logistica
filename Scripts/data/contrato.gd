extends Resource
class_name Contrato

enum Prioridad { NORMAL, URGENTE, CRITICO }

@export var destino: Gate.Destino
@export var cantidad: int
@export var prioridad: Prioridad = Prioridad.NORMAL
@export var recompensa: int
@export var penalizacion: int
