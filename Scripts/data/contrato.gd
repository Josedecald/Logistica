extends Resource
class_name Contrato

enum Prioridad { NORMAL, URGENTE, CRITICO }
enum Estado { PENDIENTE, ACEPTADO, RECHAZADO }

@export var destino: Gate.Destino
@export var cantidad: int
@export var prioridad: Prioridad = Prioridad.NORMAL
@export var recompensa: int
@export var penalizacion: int
@export var estado: Estado = Estado.PENDIENTE
@export var texto_objetivo: String
@export var frase: String
