extends RefCounted
class_name ModificadorPool

const ATENUANTES := [
	{texto = "Actuó bajo coacción o amenaza directa", valor = -12},
	{texto = "Colaboró activamente con la investigación", valor = -8},
	{texto = "No tenía antecedentes previos", valor = -6},
	{texto = "Mostró arrepentimiento genuino documentado", valor = -10},
]
const AGRAVANTES := [
	{texto = "Reincidencia comprobada", valor = 10},
	{texto = "Abusó de una posición de confianza", valor = 8},
	{texto = "Ocultó pruebas activamente", valor = 12},
	{texto = "Actuó con premeditación clara", valor = 10},
]

static func generar_aleatorio() -> Modificador:
	var mod := Modificador.new()
	if randf() < 0.5:
		var datos: Dictionary = ATENUANTES.pick_random()
		mod.tipo = Modificador.Tipo.ATENUANTE
		mod.texto = datos.texto
		mod.valor = datos.valor
	else:
		var datos: Dictionary = AGRAVANTES.pick_random()
		mod.tipo = Modificador.Tipo.AGRAVANTE
		mod.texto = datos.texto
		mod.valor = datos.valor
	return mod
