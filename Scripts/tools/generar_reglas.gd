@tool
extends EditorScript

# Ejecuta esto UNA SOLA VEZ desde el editor: File > Run (o Ctrl+Shift+X)
# con este script abierto en la pestaña de Script.

func _run() -> void:
	var carpeta := "res://Scripts/data/rules_data/"
	DirAccess.make_dir_recursive_absolute(carpeta)

	var reglas := [
		# --- Negativas -> Infierno (categoría específica) ---
		{n="corrupcion", modo=0, cat="CORRUPCION", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Corrupción -> Infierno"},
		{n="soborno", modo=0, cat="SOBORNO", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Soborno -> Infierno"},
		{n="fraude", modo=0, cat="FRAUDE", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Fraude -> Infierno"},
		{n="malversacion", modo=0, cat="MALVERSACION_FONDOS", op=0, cant=2, dest=2, niv=0, pri=12, desc="2+ Malversación de fondos -> Infierno"},
		{n="evasion", modo=0, cat="EVASION_IMPUESTOS", op=0, cant=4, dest=2, niv=0, pri=6, desc="4+ Evasión de impuestos -> Infierno"},
		{n="extorsion", modo=0, cat="EXTORSION", op=0, cant=2, dest=2, niv=0, pri=12, desc="2+ Extorsión -> Infierno"},
		{n="trafico_influencias", modo=0, cat="TRAFICO_INFLUENCIAS", op=0, cant=3, dest=2, niv=0, pri=8, desc="3+ Tráfico de influencias -> Infierno"},
		{n="lavado", modo=0, cat="LAVADO_DINERO", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Lavado de dinero -> Infierno"},
		{n="homicidio", modo=0, cat="HOMICIDIO", op=0, cant=1, dest=2, niv=0, pri=20, desc="1+ Homicidio -> Infierno"},
		{n="secuestro", modo=0, cat="SECUESTRO", op=0, cant=1, dest=2, niv=0, pri=18, desc="1+ Secuestro -> Infierno"},
		{n="violencia_domestica", modo=0, cat="VIOLENCIA_DOMESTICA", op=0, cant=2, dest=2, niv=0, pri=14, desc="2+ Violencia doméstica -> Infierno"},
		{n="narcotrafico", modo=0, cat="NARCOTRAFICO", op=0, cant=2, dest=2, niv=0, pri=16, desc="2+ Narcotráfico -> Infierno"},
		{n="abuso_poder", modo=0, cat="ABUSO_PODER", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Abuso de poder -> Infierno"},
		{n="negligencia_medica", modo=0, cat="NEGLIGENCIA_MEDICA", op=0, cant=2, dest=2, niv=0, pri=12, desc="2+ Negligencia médica -> Infierno"},
		{n="encubrimiento", modo=0, cat="ENCUBRIMIENTO", op=0, cant=3, dest=2, niv=0, pri=8, desc="3+ Encubrimiento -> Infierno"},
		{n="explotacion_laboral", modo=0, cat="EXPLOTACION_LABORAL", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Explotación laboral -> Infierno"},
		{n="abuso_religioso", modo=0, cat="ABUSO_AUTORIDAD_RELIGIOSA", op=0, cant=3, dest=2, niv=0, pri=10, desc="3+ Abuso de autoridad religiosa -> Infierno"},
		{n="robo", modo=0, cat="ROBO", op=0, cant=4, dest=2, niv=0, pri=6, desc="4+ Robo -> Infierno"},
		{n="estafa_menor", modo=0, cat="ESTAFA_MENOR", op=0, cant=4, dest=2, niv=0, pri=5, desc="4+ Estafa menor -> Infierno"},
		{n="difamacion", modo=0, cat="DIFAMACION", op=0, cant=4, dest=2, niv=0, pri=4, desc="4+ Difamación -> Infierno"},
		{n="discriminacion", modo=0, cat="DISCRIMINACION", op=0, cant=4, dest=2, niv=0, pri=6, desc="4+ Discriminación -> Infierno"},

		# --- Positivas -> Cielo (categoría específica) ---
		{n="donaciones", modo=0, cat="DONACIONES", op=0, cant=3, dest=0, niv=0, pri=8, desc="3+ Donaciones -> Cielo"},
		{n="rescate_personas", modo=0, cat="RESCATE_PERSONAS", op=0, cant=2, dest=0, niv=0, pri=15, desc="2+ Rescate de personas -> Cielo"},
		{n="trabajo_comunitario", modo=0, cat="TRABAJO_COMUNITARIO", op=0, cant=4, dest=0, niv=0, pri=6, desc="4+ Trabajo comunitario -> Cielo"},
		{n="denuncia_corrupcion", modo=0, cat="DENUNCIA_CORRUPCION", op=0, cant=3, dest=0, niv=0, pri=10, desc="3+ Denuncia de corrupción -> Cielo"},
		{n="adopcion", modo=0, cat="ADOPCION_ACOGIDA", op=0, cant=3, dest=0, niv=0, pri=10, desc="3+ Adopción o acogida -> Cielo"},
		{n="innovacion", modo=0, cat="INNOVACION_BENEFICIOSA", op=0, cant=2, dest=0, niv=0, pri=12, desc="2+ Innovación beneficiosa -> Cielo"},
		{n="defensa_ddhh", modo=0, cat="DEFENSA_DERECHOS_HUMANOS", op=0, cant=3, dest=0, niv=0, pri=10, desc="3+ Defensa de derechos humanos -> Cielo"},
		{n="sacrificio_personal", modo=0, cat="SACRIFICIO_PERSONAL", op=0, cant=1, dest=0, niv=0, pri=18, desc="1+ Sacrificio personal -> Cielo"},
		{n="mentoria", modo=0, cat="MENTORIA_EDUCACION", op=0, cant=4, dest=0, niv=0, pri=6, desc="4+ Mentoría o educación -> Cielo"},

		# --- Respaldo real, no error de emergencia ---
		{n="respaldo_reencarnacion", modo=1, cat="CORRUPCION", op=0, cant=-999, dest=1, niv=0, pri=-1, desc="Ninguna regla anterior aplicó -> Reencarnación (trámite estándar)"},
	]

	var creadas := 0
	for r in reglas:
		var rule := RuleSimple.new()
		rule.modo = r.modo
		if r.modo == 0:
			rule.categoria = Incidente.Categoria[r.cat]
		rule.operador = r.op
		rule.cantidad = r.cant
		rule.destino = r.dest
		rule.nivel = r.niv
		rule.prioridad = r.pri
		rule.descripcion = r.desc

		var path = carpeta + r.n + ".tres"
		var err := ResourceSaver.save(rule, path)
		if err == OK:
			creadas += 1
		else:
			push_error("Error guardando %s: %d" % [path, err])

	print("Reglas creadas: ", creadas, " / ", reglas.size())
