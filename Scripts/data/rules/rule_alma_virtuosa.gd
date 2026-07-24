extends Rule
class_name RuleAlmaVirtuosa

func evaluate(case_file: CaseFile) -> bool:
	var positivos := case_file.incidentes.filter(
		func(i: Incidente): return IncidentePesos.PESO.get(i.categoria, 0) < 0
	)
	return positivos.size() >= 3 and not case_file.tiene_incidentes_negativos()
