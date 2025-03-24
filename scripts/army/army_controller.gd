## Clase que maneja las unidades del jugador.
class_name ArmyController extends Node2D

@export var archer_scene: PackedScene  # Carga la escena de Archer
@export var unit_attack_cooldown: float = 0.5  # Enfriamiento entre ataques
var can_attack: bool = true  # Indica si las unidades pueden atacar
var units = []  # Lista para almacenar las unidades

func _ready():
	spawn_units(3)  # Instancia 3 unidades
	get_parent().beat.connect(_on_beat)

## Instancia y coloca las unidades en la pantalla.
func spawn_units(count: int):
	var screen_center = get_viewport_rect().size.x / 2
	var total_width = count * 50
	var start_x = screen_center - (total_width / 2.0)
	for i in range(count):
		var unit = archer_scene.instantiate()  # Usamos la escena del Archer
		unit.position = Vector2(start_x + (i * 50), 200)
		units.append(unit)  # Añadimos la unidad a la lista
		$UnitsContainer.add_child(unit)

## Método que maneja los ataques (puedes personalizarlo para diferentes tipos de unidades)
func attack_units():
	if can_attack:
		can_attack = false  # Desactivamos el ataque mientras se está realizando el enfriamiento
		for unit in units:
			unit.attack()  # Llamamos al método de ataque de cada unidad
		await get_tree().create_timer(unit_attack_cooldown).timeout  # Esperamos el enfriamiento
		can_attack = true  # Volvemos a activar el ataque

func _on_beat():
	attack_units()  # Ordenamos a las unidades que ataquen en el beat
