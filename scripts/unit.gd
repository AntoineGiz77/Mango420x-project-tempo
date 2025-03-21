## Clase que maneja el comportamiento de la unidad en el juego, incluyendo el salto.
## La unidad se mueve de manera suave utilizando una función seno para simular un salto natural.
class_name Unit extends Node2D

## Propiedades exportadas
@export var jump_height: float = 50.0  ## Altura máxima del salto (ajustable desde el editor).
@export var jump_duration: float = 0.3  ## Duración del salto en segundos (ajustable desde el editor).

## Propiedades internas de la clase
var jumping: bool = false  ## Indica si la unidad está saltando (true/false).
var jump_progress: float = 0.0  ## Progreso del salto, entre 0 y 1, que se actualiza con el tiempo.
var initial_position_y: float = 0.0  ## Guarda la posición Y inicial de la unidad para calcular el salto.

## Método llamado cuando la unidad es creada o inicializada.
## Guarda la posición inicial de la unidad en Y para usarla en el cálculo del salto.
func _ready():
	initial_position_y = position.y  ## Guardamos la posición inicial en Y de la unidad.

## Método que se llama para iniciar el salto de la unidad.
## Resetea el progreso del salto y marca a la unidad como saltando.
func jump():
	if not jumping:  ## Solo inicia el salto si la unidad no está ya saltando.
		jumping = true
		jump_progress = 0.0  ## Reseteamos el progreso del salto a 0 al comenzar el salto.

## Método que se ejecuta cada frame.
## Se encarga de actualizar la posición de la unidad mientras está saltando.
func _process(delta):
	if jumping:  ## Solo actualiza la posición si la unidad está saltando.
		## Aumentamos el progreso del salto de acuerdo al tiempo que ha pasado.
		jump_progress += delta / jump_duration  ## Calculamos el progreso del salto basado en el tiempo transcurrido.

		## Usamos una función seno para hacer que el salto sea suave (sube hasta la altura máxima y luego baja).
		var y_offset = jump_height * sin(jump_progress * PI)  ## Movimiento suave con función seno.

		## Actualizamos la posición Y de la unidad, para simular el salto.
		position.y = initial_position_y - y_offset  ## Subimos o bajamos la unidad.

		## Si el salto ha terminado (cuando el progreso llega a 1.0), la unidad vuelve a su posición inicial.
		if jump_progress >= 1.0:
			jumping = false  ## La unidad deja de saltar.
			position.y = initial_position_y  ## Aseguramos que la unidad quede en su posición inicial en Y.
