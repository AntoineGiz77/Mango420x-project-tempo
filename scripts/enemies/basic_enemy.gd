## Clase que maneja el comportamiento del enemigo básico.
class_name BasicEnemy extends CharacterBody2D

## Propiedades exportadas.
@export var max_health: int = 100  ## Vida máxima del enemigo.
@export var attack_damage: int = 10  ## Daño que inflige el enemigo.

## Señal emitida cuando el enemigo es derrotado.
signal enemy_defeated

## Propiedades internas.
var current_health: int  ## Vida actual del enemigo.

## Método llamado cuando la escena se inicializa.
func _ready():
	current_health = max_health  ## Inicializa la vida actual.

## Función para recibir daño.
func take_damage(damage: int):
	current_health -= damage  ## Reduce la vida del enemigo.
	print("Enemigo recibió ", damage, " de daño. Vida restante: ", current_health)
	
	if current_health <= 0:
		die()  ## Llama a la función de muerte si la vida llega a 0.

## Función para manejar la muerte del enemigo.
func die():
	print("¡Enemigo derrotado!")
	emit_signal("enemy_defeated")  ## Notifica que el enemigo fue derrotado.
	queue_free()  ## Elimina al enemigo de la escena.
