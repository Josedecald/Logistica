extends Rule

enum Modo { CONTAR_CATEGORIA, PUNTAJE_TOTAL }
enum Operador { MAYOR_IGUAL, MENOR_IGUAL, IGUAL }

@export var modo: Modo = Modo.CONTAR_CATEGORIA
@export var categoria: Incidente.Categoria
@export var operador: Operador = Operador.MAYOR_IGUAL
@export var cantidad: int = 3

func evaluate(case_file: CaseFile) -> bool:
	var valor: int
	if modo == Modo.CONTAR_CATEGORIA:
		valor = case_file.contar_incidentes(categoria)
	else:
		valor = case_file.calcular_puntaje()

	match operador:
		Operador.MAYOR_IGUAL: return valor >= cantidad
		Operador.MENOR_IGUAL: return valor <= cantidad
		Operador.IGUAL: return valor == cantidad
	return false
