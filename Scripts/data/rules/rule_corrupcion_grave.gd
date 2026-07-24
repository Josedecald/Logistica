extends Rule
class_name RuleCorrupcionGrave

func evaluate(case_file: CaseFile) -> bool:
	return case_file.contar_incidentes(Incidente.Categoria.CORRUPCION) >= 3
