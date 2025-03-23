## Clase que maneja las unidades del jugador.
class_name ArmyController extends Node2D

@export var unit_scene: PackedScene

func _ready():
	spawn_units(3)
	get_parent().beat.connect(_on_beat)

## Instancia y coloca unidades en la pantalla.
func spawn_units(count: int):
	var screen_center = get_viewport_rect().size.x / 2
	var total_width = count * 50
	var start_x = screen_center - (total_width / 2.0)
	for i in range(count):
		var unit = unit_scene.instantiate()
		unit.position = Vector2(start_x + (i * 50), 200)
		$UnitsContainer.add_child(unit)

## Ordena a las unidades que salten en la dirección del input.
func jump_units(_direction: String):
	for unit in $UnitsContainer.get_children():
		unit.jump()

func _on_beat():
	pass
