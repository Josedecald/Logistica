extends RefCounted
class_name NombreGenerador

const NOMBRES := ["Carlos", "María", "Luis", "Ana", "Jorge", "Sofía", "Pedro", "Valentina", "Andrés", "Camila"]
const APELLIDOS := ["Mendoza", "Restrepo", "Gómez", "Cárdenas", "Vargas", "Rojas", "Salazar", "Torres"]

static func generar() -> String:
	return "%s %s" % [NOMBRES.pick_random(), APELLIDOS.pick_random()]
