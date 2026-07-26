extends Node

signal expediente_generado(case_file: CaseFile)

var nombres_usados: Array[String] = []
const PROBABILIDAD_REINCIDENCIA := 0.40
const MAX_REGISTROS_POR_INCIDENTE := 4

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

	var cantidad_categorias := randi_range(1, 4)
	for i in min(cantidad_categorias, compatibles.size()):
		var categoria: Incidente.Categoria = compatibles[i]
		var registros := 1
		# Un hecho puede tener varios registros administrativos. Esto permite que
		# reglas como "3+ Fraude" sean posibles sin repetir líneas en el expediente.
		if randf() < PROBABILIDAD_REINCIDENCIA:
			registros = randi_range(2, MAX_REGISTROS_POR_INCIDENTE)
		var incidente := Incidente.new()
		incidente.categoria = categoria
		incidente.texto = TextosIncidente.obtener_texto(categoria)
		incidente.cantidad_registros = registros
		case_file.incidentes.append(incidente)
		
	if randf() < 0.4:  # 40% de las almas tienen algo que investigar
		var cantidad_ocultos := randi_range(1, 2)
		for i in cantidad_ocultos:
			case_file.modificadores_ocultos.append(ModificadorPool.generar_aleatorio())

	expediente_generado.emit(case_file)
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
