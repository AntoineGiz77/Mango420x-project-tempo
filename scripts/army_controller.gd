extends Node2D

@export var unit_scene: PackedScene  # Asignamos la escena de unidad en el editor
@onready var units_container = $UnitsContainer  # Contenedor de las unidades

# Conexión con la señal de GameScene (ahora más flexible y con validación)
func _ready():
	spawn_units(3)  # Generamos 3 unidades de prueba
	var game_scene = get_tree().root.get_node("GameScene")  # Busca el nodo GameScene desde el árbol de nodos raíz
	if game_scene:
		# Aquí usamos Callable para conectar la señal
		game_scene.connect("beat", Callable(self, "_on_beat"))  # Conecta la señal 'beat' de GameScene a la función _on_beat
	else:
		print("No se ha encontrado GameScene.")

# Método para instanciar unidades en la pantalla
func spawn_units(count: int):
	var screen_center = get_viewport_rect().size.x / 2  # Centra en la pantalla
	var total_width = count * 50  # Asumiendo que cada unidad ocupa 50px de ancho
	var start_x = screen_center - (total_width / 2)  # Ajuste para que se vean centradas

	for i in range(count):
		var unit = unit_scene.instantiate()  # Instancia la unidad
		unit.position = Vector2(start_x + (i * 50), 200)  # Posiciona cada unidad en el centro y un poco hacia abajo
		units_container.add_child(unit)  # Añade la unidad al contenedor de unidades

# Método que se llama con cada beat para hacer saltar las unidades
func _on_beat():
	for unit in units_container.get_children():  # Itera por todas las unidades
		unit.jump()  # Llama al método jump de la unidad (Unit.gd)
	print("¡Ejército saltando en el beat!")  # Para debug
