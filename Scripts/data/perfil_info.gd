extends RefCounted
class_name PerfilInfo

const TITULOS := {
	Perfil.Tipo.SERVIDOR_PUBLICO: ["Alcalde", "Concejal", "Ministro", "Funcionario municipal"],
	Perfil.Tipo.EMPRESARIO: ["Empresario", "Dueño de fábrica", "Inversionista"],
	Perfil.Tipo.COMERCIANTE: ["Panadero", "Tendero", "Vendedor ambulante"],
	Perfil.Tipo.MEDICO: ["Cirujano", "Médico general", "Pediatra"],
	Perfil.Tipo.DOCENTE: ["Maestro de escuela", "Profesor universitario"],
	Perfil.Tipo.MILITAR: ["Soldado", "Coronel", "General"],
	Perfil.Tipo.POLICIA: ["Oficial de policía", "Detective"],
	Perfil.Tipo.PERIODISTA: ["Periodista", "Reportero de investigación"],
	Perfil.Tipo.CIENTIFICO: ["Investigador", "Químico", "Biólogo"],
	Perfil.Tipo.LIDER_RELIGIOSO: ["Sacerdote", "Pastor"],
	Perfil.Tipo.CRIMINAL_ORGANIZADO: ["Capo", "Sicario", "Jefe de cártel"],
	Perfil.Tipo.CIUDADANO_COMUN: ["Ama de casa", "Estudiante", "Obrero", "Jubilado", "Niño"],
}

const RANGO_EDAD := {
	Perfil.Tipo.SERVIDOR_PUBLICO: Vector2i(30, 75),
	Perfil.Tipo.EMPRESARIO: Vector2i(28, 80),
	Perfil.Tipo.COMERCIANTE: Vector2i(18, 85),
	Perfil.Tipo.MEDICO: Vector2i(28, 75),
	Perfil.Tipo.DOCENTE: Vector2i(24, 80),
	Perfil.Tipo.MILITAR: Vector2i(19, 65),
	Perfil.Tipo.POLICIA: Vector2i(21, 60),
	Perfil.Tipo.PERIODISTA: Vector2i(23, 70),
	Perfil.Tipo.CIENTIFICO: Vector2i(25, 80),
	Perfil.Tipo.LIDER_RELIGIOSO: Vector2i(25, 90),
	Perfil.Tipo.CRIMINAL_ORGANIZADO: Vector2i(16, 65),
	Perfil.Tipo.CIUDADANO_COMUN: Vector2i(1, 95),
}

const INCIDENTES_COMPATIBLES := {
	Perfil.Tipo.SERVIDOR_PUBLICO: [Incidente.Categoria.CORRUPCION, Incidente.Categoria.SOBORNO, Incidente.Categoria.MALVERSACION_FONDOS, Incidente.Categoria.TRAFICO_INFLUENCIAS, Incidente.Categoria.ABUSO_PODER, Incidente.Categoria.TRABAJO_COMUNITARIO, Incidente.Categoria.DONACIONES],
	Perfil.Tipo.EMPRESARIO: [Incidente.Categoria.FRAUDE, Incidente.Categoria.EVASION_IMPUESTOS, Incidente.Categoria.LAVADO_DINERO, Incidente.Categoria.EXPLOTACION_LABORAL, Incidente.Categoria.DONACIONES, Incidente.Categoria.INNOVACION_BENEFICIOSA],
	Perfil.Tipo.COMERCIANTE: [Incidente.Categoria.ESTAFA_MENOR, Incidente.Categoria.EVASION_IMPUESTOS, Incidente.Categoria.ROBO, Incidente.Categoria.TRABAJO_COMUNITARIO, Incidente.Categoria.DONACIONES],
	Perfil.Tipo.MEDICO: [Incidente.Categoria.NEGLIGENCIA_MEDICA, Incidente.Categoria.SOBORNO, Incidente.Categoria.INNOVACION_BENEFICIOSA, Incidente.Categoria.RESCATE_PERSONAS, Incidente.Categoria.MENTORIA_EDUCACION],
	Perfil.Tipo.DOCENTE: [Incidente.Categoria.ABUSO_PODER, Incidente.Categoria.DIFAMACION, Incidente.Categoria.MENTORIA_EDUCACION, Incidente.Categoria.DEFENSA_DERECHOS_HUMANOS],
	Perfil.Tipo.MILITAR: [Incidente.Categoria.HOMICIDIO, Incidente.Categoria.ABUSO_PODER, Incidente.Categoria.ENCUBRIMIENTO, Incidente.Categoria.SACRIFICIO_PERSONAL, Incidente.Categoria.RESCATE_PERSONAS],
	Perfil.Tipo.POLICIA: [Incidente.Categoria.ABUSO_PODER, Incidente.Categoria.ENCUBRIMIENTO, Incidente.Categoria.SOBORNO, Incidente.Categoria.RESCATE_PERSONAS, Incidente.Categoria.DEFENSA_DERECHOS_HUMANOS],
	Perfil.Tipo.PERIODISTA: [Incidente.Categoria.DIFAMACION, Incidente.Categoria.DENUNCIA_CORRUPCION, Incidente.Categoria.DEFENSA_DERECHOS_HUMANOS],
	Perfil.Tipo.CIENTIFICO: [Incidente.Categoria.INNOVACION_BENEFICIOSA, Incidente.Categoria.FRAUDE, Incidente.Categoria.NEGLIGENCIA_MEDICA],
	Perfil.Tipo.LIDER_RELIGIOSO: [Incidente.Categoria.ABUSO_AUTORIDAD_RELIGIOSA, Incidente.Categoria.ENCUBRIMIENTO, Incidente.Categoria.DONACIONES, Incidente.Categoria.MENTORIA_EDUCACION],
	Perfil.Tipo.CRIMINAL_ORGANIZADO: [Incidente.Categoria.NARCOTRAFICO, Incidente.Categoria.EXTORSION, Incidente.Categoria.HOMICIDIO, Incidente.Categoria.SECUESTRO, Incidente.Categoria.LAVADO_DINERO],
	Perfil.Tipo.CIUDADANO_COMUN: [Incidente.Categoria.ROBO, Incidente.Categoria.ESTAFA_MENOR, Incidente.Categoria.VIOLENCIA_DOMESTICA, Incidente.Categoria.DISCRIMINACION, Incidente.Categoria.DONACIONES, Incidente.Categoria.RESCATE_PERSONAS, Incidente.Categoria.TRABAJO_COMUNITARIO, Incidente.Categoria.SACRIFICIO_PERSONAL],
}
