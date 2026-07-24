extends Rule
class_name RuleBalanceModerado

func evaluate(case_file: CaseFile) -> bool:
	return case_file.calcular_puntaje() >= 25
