# Clase Flecha que se mueve hacia el enemigo.
class_name Arrow
extends Node2D

@export var target: Node2D  # El objetivo hacia el cual va la flecha.
@export var speed: float = 300.0  # Velocidad de la flecha.

# Función que se llama en cada frame.
func _process(delta):
	if target:
		# Calculamos la dirección hacia el objetivo.
		var direction = (target.position - position).normalized()
		position += direction * speed * delta  # Movemos la flecha hacia el objetivo.

		# Si la flecha toca al enemigo, inflige daño y se destruye.
		if position.distance_to(target.position) < 10:
			target.take_damage(10)  # Inflige 10 de daño al enemigo.
			queue_free()  # Elimina la flecha de la escena.
