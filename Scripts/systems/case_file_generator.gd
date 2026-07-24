extends Node

var nombres_usados: Array[String] = []

func generar() -> CaseFile:
	var perfil: Perfil.Tipo = PerfilInfo.TITULOS.keys().pick_random()
	var rango: Vector2i = PerfilInfo.RANGO_EDAD[perfil]
	var edad := randi_range(rango.x, rango.y)

	var case_file := CaseFile.new()
	case_file.nombre = _generar_nombre_unico()
	case_file.edad = edad
	case_file.profesion = PerfilInfo.TITULOS[perfil].pick_random()
	case_file.causa_defuncion = ["Infarto", "Accidente", "Enfermedad", "Vejez"].pick_random()

	var compatibles: Array = PerfilInfo.INCIDENTES_COMPATIBLES[perfil].filter(
		func(c): return edad >= EdadMinima.MINIMA.get(c, 0)
	)
	compatibles.shuffle()

	var cantidad := randi_range(1, 4)
	for i in min(cantidad, compatibles.size()):
		var incidente := Incidente.new()
		incidente.categoria = compatibles[i]
		incidente.texto = TextosIncidente.obtener_texto(compatibles[i])
		case_file.incidentes.append(incidente)

	return case_file

func _generar_nombre_unico() -> String:
	var intentos := 0
	while intentos < 20:
		var nombre := NombreGenerador.generar()
		if nombre not in nombres_usados:
			nombres_usados.append(nombre)
			return nombre
		intentos += 1
	# Se agotó el pool de combinaciones únicas — agrega más nombres/apellidos si esto pasa seguido.
	return "%s (caso %d)" % [NombreGenerador.generar(), nombres_usados.size()]
