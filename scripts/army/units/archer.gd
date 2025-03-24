class_name Archer
extends Unit

@export var arrow_scene: PackedScene  ## El proyectil que lanzará el arquero (flecha)

## Sobrescribimos la función de ataque para que el arquero lance una flecha.
func attack():
	sprite.play("attack")  # Cambia la animación a daño
	await get_tree().create_timer(1).timeout  # Espera 0.5s para volver a idle
	sprite.play("idle")  
	
	var enemy = get_closest_enemy()  # Usamos la función para obtener el enemigo más cercano.
	
	if enemy:  # Si encontramos un enemigo cercano, lanzamos la flecha.
		var arrow = arrow_scene.instantiate()  # Instanciamos una flecha.
		arrow.position = position  # Ponemos la flecha en la posición del arquero.
		arrow.target = enemy  # La flecha va hacia el enemigo más cercano.
		get_parent().add_child(arrow)  # Agregamos la flecha a la escena.
		
		# Podrías añadir un sonido o una animación aquí si lo deseas.

## Función para encontrar el enemigo más cercano.
func get_closest_enemy() -> CharacterBody2D:
	var closest_enemy = null
	var closest_distance = attack_range  # Usamos el rango de ataque heredado de la clase base.

	# Buscamos a los enemigos dentro del rango.
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var distance = position.distance_to(enemy.position)
		if distance < closest_distance:
			closest_enemy = enemy
			closest_distance = distance  # Actualizamos la distancia más cercana
	
	return closest_enemy  # Retornamos el enemigo más cercano, si lo encontramos.
