extends RefCounted
class_name TextosIncidente

const TEXTOS := {
	Incidente.Categoria.CORRUPCION: [
		"Recibió sobornos de contratistas",
		"Desvió fondos de obras públicas"
	],

	Incidente.Categoria.SOBORNO: [
		"Aceptó dinero para alterar el resultado de una licitación",
		"Cobró por acelerar trámites que debían ser gratuitos"
	],

	Incidente.Categoria.FRAUDE: [
		"Falsificó documentos para obtener beneficios económicos",
		"Creó una empresa fantasma para engañar inversionistas"
	],

	Incidente.Categoria.MALVERSACION_FONDOS: [
		"Usó dinero público para gastos personales",
		"Desapareció recursos destinados a programas sociales"
	],

	Incidente.Categoria.EVASION_IMPUESTOS: [
		"Ocultó ingresos durante años para evitar impuestos",
		"Creó sociedades ficticias para reducir su carga fiscal"
	],

	Incidente.Categoria.EXTORSION: [
		"Amenazó a comerciantes para cobrar protección",
		"Exigió dinero bajo amenaza de revelar información privada"
	],

	Incidente.Categoria.TRAFICO_INFLUENCIAS: [
		"Consiguió contratos aprovechando sus contactos políticos",
		"Intercedió ilegalmente para favorecer a un familiar"
	],

	Incidente.Categoria.LAVADO_DINERO: [
		"Blanqueó ganancias ilícitas mediante negocios legales",
		"Movió dinero de origen criminal entre múltiples empresas"
	],

	Incidente.Categoria.HOMICIDIO: [
		"Asesinó a un rival durante una disputa",
		"Provocó deliberadamente la muerte de una persona"
	],

	Incidente.Categoria.SECUESTRO: [
		"Mantuvo cautiva a una víctima para exigir un rescate",
		"Privó ilegalmente de la libertad a un empresario"
	],

	Incidente.Categoria.VIOLENCIA_DOMESTICA: [
		"Agredió repetidamente a un miembro de su familia",
		"Mantuvo años de maltrato físico y psicológico en su hogar"
	],

	Incidente.Categoria.NARCOTRAFICO: [
		"Dirigió una red de distribución de drogas",
		"Financió rutas de transporte para sustancias ilícitas"
	],

	Incidente.Categoria.ABUSO_PODER: [
		"Utilizó su cargo para intimidar a subordinados",
		"Tomó decisiones arbitrarias para beneficio propio"
	],

	Incidente.Categoria.NEGLIGENCIA_MEDICA: [
		"Ignoró protocolos médicos causando daños evitables",
		"Abandonó a un paciente que requería atención urgente"
	],

	Incidente.Categoria.ENCUBRIMIENTO: [
		"Ocultó pruebas para proteger a un culpable",
		"Destruyó evidencia durante una investigación"
	],

	Incidente.Categoria.EXPLOTACION_LABORAL: [
		"Obligó a empleados a trabajar sin remuneración justa",
		"Impuso jornadas abusivas ignorando las condiciones humanas"
	],

	Incidente.Categoria.ABUSO_AUTORIDAD_RELIGIOSA: [
		"Manipuló a sus seguidores para obtener beneficios personales",
		"Utilizó su posición espiritual para controlar y someter personas"
	],

	Incidente.Categoria.ROBO: [
		"Robó mercancía de su propio negocio para cobrar el seguro",
		"Sustrajo dinero de la caja registradora"
	],

	Incidente.Categoria.ESTAFA_MENOR: [
		"Vendió productos que nunca entregó",
		"Engañó a compradores mediante anuncios falsos"
	],

	Incidente.Categoria.DIFAMACION: [
		"Inventó acusaciones que destruyeron la reputación de otra persona",
		"Propagó rumores falsos con intención de perjudicar"
	],

	Incidente.Categoria.DISCRIMINACION: [
		"Negó oportunidades laborales por prejuicios personales",
		"Excluyó sistemáticamente a personas por su origen"
	],

	Incidente.Categoria.DONACIONES: [
		"Donó parte de sus ingresos a un comedor comunitario",
		"Financió una escuela rural en secreto"
	],

	Incidente.Categoria.RESCATE_PERSONAS: [
		"Arriesgó su vida para salvar a una familia durante un incendio",
		"Rescató a varias personas atrapadas en una inundación"
	],

	Incidente.Categoria.TRABAJO_COMUNITARIO: [
		"Organizó jornadas de limpieza en su comunidad",
		"Reparó viviendas de familias vulnerables como voluntario"
	],

	Incidente.Categoria.DENUNCIA_CORRUPCION: [
		"Denunció una red de corrupción pese a recibir amenazas",
		"Reveló irregularidades que afectaban recursos públicos"
	],

	Incidente.Categoria.ADOPCION_ACOGIDA: [
		"Adoptó a un niño que llevaba años sin familia",
		"Acogió temporalmente a menores en situación de riesgo"
	],

	Incidente.Categoria.INNOVACION_BENEFICIOSA: [
		"Desarrolló una tecnología que mejoró la calidad de vida de miles",
		"Creó una solución médica accesible para comunidades aisladas"
	],

	Incidente.Categoria.DEFENSA_DERECHOS_HUMANOS: [
		"Protegió a personas perseguidas pese al riesgo personal",
		"Defendió los derechos de comunidades vulnerables durante años"
	],

	Incidente.Categoria.SACRIFICIO_PERSONAL: [
		"Entregó su vida para salvar a otras personas",
		"Renunció a todo su patrimonio para proteger a su familia"
	],

	Incidente.Categoria.MENTORIA_EDUCACION: [
		"Enseñó gratuitamente a jóvenes de escasos recursos",
		"Dedicó años a formar estudiantes sin recibir remuneración"
	],
}

static func obtener_texto(categoria: Incidente.Categoria) -> String:
	var opciones: Array = TEXTOS.get(categoria, ["Incidente sin detalle registrado"])
	return opciones.pick_random()
