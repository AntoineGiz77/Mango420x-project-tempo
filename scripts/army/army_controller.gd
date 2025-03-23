## Clase encargada de gestionar el spawn de las unidades y las acciones de dichos.
class_name ArmyController extends Node2D

## Propiedades exportadas
@export var unit_scene: PackedScene  ## Asignamos la escena de unidad en el editor para poder instanciarla más tarde.

## Método que se ejecuta cuando la escena se inicializa.
## Este método genera las unidades y conecta la señal de "beat".
func _ready():
	spawn_units(3)  ## Generamos 3 unidades en el escenario.
	get_parent().beat.connect(_on_beat)  ## Conecta la señal de "beat" con la función _on_beat para reaccionar al ritmo.

## Función que genera un número dado de unidades en el escenario.
## Las unidades se colocan de manera que estén centradas en la pantalla.
func spawn_units(count: int):
	var screen_center = get_viewport_rect().size.x / 2  ## Obtiene el centro de la pantalla para centrar las unidades.
	var total_width = count * 50  ## Asumimos que cada unidad ocupa 50px de ancho.
	var start_x = screen_center - (total_width / 2.0)  ## Calcula la posición inicial de las unidades para que estén centradas en el eje X.
	
	# Itera para instanciar y agregar las unidades al contenedor
	for i in range(count):
		var unit = unit_scene.instantiate()  ## Instancia una unidad de la escena asignada en el editor.
		unit.position = Vector2(start_x + (i * 50), 200)  ## Ajusta la posición de la unidad. La altura es fija en 200, ajusta según sea necesario.
		$UnitsContainer.add_child(unit)  ## Agrega la unidad al contenedor para que se visualice en el juego.

## Función que hace saltar las unidades cuando el jugador hace la entrada correcta.
## Recibe la dirección del input del jugador para realizar la acción.
func jump_units(_direction: String):
	# Itera por cada unidad en el contenedor y les hace ejecutar su salto.
	for unit in $UnitsContainer.get_children():
		unit.jump()  ## Llama a la función de salto de cada unidad. Puedes modificar cómo se realiza el salto.

## Función llamada cuando ocurre un beat.
## Aquí puedes agregar cualquier acción que desees que suceda durante cada beat del ritmo.
func _on_beat():
	print("¡Ejército atacando en el beat!")  ## Por ahora, solo imprime un mensaje en consola para probar que la función se ejecuta.
