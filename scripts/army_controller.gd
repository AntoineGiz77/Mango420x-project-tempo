extends Node2D

@export var unit_scene: PackedScene  # Asignamos la escena de unidad en el editor

func _ready():
	spawn_units(3)  # Generamos 5 unidades de prueba
	get_parent().beat.connect(_on_beat)  # Escucha la señal del ritmo

func spawn_units(count: int):
	var screen_center = get_viewport_rect().size.x / 2  # Obtiene el centro de la pantalla
	var total_width = count * 50  # Asumiendo que cada unidad ocupa 50px de ancho
	var start_x = screen_center - (total_width / 2)  # Ajusta el inicio para centrar
	
	for i in range(count):
		var unit = unit_scene.instantiate()
		unit.position = Vector2(start_x + (i * 50), 200)  # 200 es la altura, ajústala según necesites
		$UnitsContainer.add_child(unit)

func _on_beat():
	for unit in $UnitsContainer.get_children():
		unit.animate_beat()
	print("¡Ejército atacando en el beat!")  # Luego lo cambiaremos por animaciones o ataques
