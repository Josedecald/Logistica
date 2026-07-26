extends Node

const TAMANO_MUESTRA := 100

var total := 0
var conteos := {
	Gate.Destino.CIELO: 0,
	Gate.Destino.REENCARNACION: 0,
	Gate.Destino.INFIERNO: 0,
}

func _ready() -> void:
	CaseFileGenerator.expediente_generado.connect(_registrar_expediente)

func _registrar_expediente(case_file: CaseFile) -> void:
	if total >= TAMANO_MUESTRA:
		return
	var destino := ClassificationManager.destino_correcto(case_file)
	conteos[destino] += 1
	total += 1

func texto_resumen() -> String:
	var estado := "MUESTRA COMPLETA" if total >= TAMANO_MUESTRA else "MUESTRA DE BALANCE"
	return "%s %d/%d\nCielo %d · Reencarnación %d · Infierno %d" % [estado, total, TAMANO_MUESTRA, conteos[Gate.Destino.CIELO], conteos[Gate.Destino.REENCARNACION], conteos[Gate.Destino.INFIERNO]]

func reiniciar() -> void:
	total = 0
	for destino in conteos:
		conteos[destino] = 0
