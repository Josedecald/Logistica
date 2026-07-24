extends Node

var reglas: Array[Rule] = []
var niveles_activos: Array[Rule.Nivel] = [Rule.Nivel.FACIL, Rule.Nivel.MEDIO]


func _ready() -> void:
	_cargar_reglas()
	reglas.sort_custom(func(a, b): return a.prioridad > b.prioridad)

func _cargar_reglas() -> void:
	var dir := DirAccess.open("res://Scripts/data/rules_data/")
	if dir == null:
		push_error("No se encontró la carpeta de reglas: res://Scripts/data/rules_data/")
		return
	
	print("Cargando reglas desde: res://Scripts/data/rules_data/")
	var archivos := dir.get_files()
	print("Archivos encontrados: ", archivos)
	
	for file_name in archivos:
		if file_name.ends_with(".tres"):
			var ruta_completa := "res://Scripts/data/rules_data/" + file_name
			print("Intentando cargar: ", ruta_completa)
			var rule := load(ruta_completa) as Rule
			if rule:
				print("Regla cargada exitosamente: ", rule.descripcion)
				reglas.append(rule)
			else:
				push_error("No se pudo cargar la regla: " + ruta_completa)
	
	print("Total de reglas cargadas: ", reglas.size())

func destino_correcto(case_file: CaseFile) -> Gate.Destino:
	for rule in reglas:
		if rule.nivel in niveles_activos and rule.evaluate(case_file):
			return rule.destino
	return Gate.Destino.REENCARNACION  # valor de emergencia solo para no crashear

func es_correcto(destino_enviado: Gate.Destino, case_file: CaseFile) -> bool:
	return destino_enviado == destino_correcto(case_file)
