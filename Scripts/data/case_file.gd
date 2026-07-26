extends Resource
class_name CaseFile

@export var nombre: String
@export var edad: int
@export var profesion: String
@export var causa_defuncion: String

@export var incidentes: Array[Incidente] = []
@export var modificadores: Array[Modificador] = []
@export var observaciones: Array[String] = []

@export var modificadores_ocultos: Array[Modificador] = []

func contar_incidentes(categoria: Incidente.Categoria) -> int:
	var count := 0
	for incidente in incidentes:
		if incidente.categoria == categoria:
			count += incidente.cantidad_registros
	return count

func tiene_incidentes_negativos() -> bool:
	for incidente in incidentes:
		if IncidentePesos.PESO.get(incidente.categoria, 0) > 0:
			return true
	return false

func calcular_puntaje() -> int:
	var puntaje := 0
	for incidente in incidentes:
		puntaje += IncidentePesos.PESO.get(incidente.categoria, 0) * incidente.cantidad_registros
	for modificador in modificadores:
		puntaje += modificador.valor
	# Los anexos sellados ya forman parte del expediente administrativo. Revelarlos
	# informa al jugador, pero no debe alterar cuál era el destino correcto.
	for modificador in modificadores_ocultos:
		puntaje += modificador.valor
	return puntaje
	

func revelar_ocultos() -> void:
	modificadores.append_array(modificadores_ocultos)
	modificadores_ocultos.clear()
