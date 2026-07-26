extends Node

var reglas: Array[Rule] = []
var niveles_activos: Array[Rule.Nivel] = [Rule.Nivel.FACIL, Rule.Nivel.MEDIO]


func _ready() -> void:
	_cargar_reglas()
	reglas.sort_custom(_comparar_precedencia)

func _comparar_precedencia(a: Rule, b: Rule) -> bool:
	if a.prioridad != b.prioridad:
		return a.prioridad > b.prioridad
	# El desempate alfabético evita que el orden del sistema de archivos decida un caso.
	return a.descripcion < b.descripcion

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

func regla_aplicada(case_file: CaseFile) -> Rule:
	var aplicables := reglas_aplicables(case_file)
	if aplicables.is_empty():
		return null
	_verificar_conflicto_de_precedencia(aplicables, case_file)
	return aplicables[0]

func reglas_aplicables(case_file: CaseFile) -> Array[Rule]:
	var aplicables: Array[Rule] = []
	for rule in reglas:
		if rule.nivel in niveles_activos and rule.evaluate(case_file):
			aplicables.append(rule)
	return aplicables

func _verificar_conflicto_de_precedencia(aplicables: Array[Rule], case_file: CaseFile) -> void:
	if aplicables.size() < 2:
		return
	var principal: Rule = aplicables[0]
	for rule in aplicables.slice(1):
		if rule.prioridad == principal.prioridad and rule.destino != principal.destino:
			push_warning("Conflicto de reglas con la misma precedencia para %s: %s / %s" % [case_file.nombre, principal.descripcion, rule.descripcion])

func destino_correcto(case_file: CaseFile) -> Gate.Destino:
	var rule := regla_aplicada(case_file)
	if rule:
		return rule.destino
	push_error("Ninguna regla aplicó al expediente de: " + case_file.nombre)
	return Gate.Destino.REENCARNACION

func es_correcto(destino_enviado: Gate.Destino, case_file: CaseFile) -> bool:
	return destino_enviado == destino_correcto(case_file)
