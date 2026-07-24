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
	for file_name in dir.get_files():
		if file_name.ends_with(".tres"):
			var rule := load("res://Scripts/data/rules_data/" + file_name) as Rule
			if rule:
				reglas.append(rule)

func destino_correcto(case_file: CaseFile) -> Gate.Destino:
	for rule in reglas:
		if rule.nivel in niveles_activos and rule.evaluate(case_file):
			return rule.destino
	return Gate.Destino.REENCARNACION  # valor de emergencia solo para no crashear

func es_correcto(destino_enviado: Gate.Destino, case_file: CaseFile) -> bool:
	return destino_enviado == destino_correcto(case_file)
