## Clase que maneja la lógica de la primera zona.
class_name FirstZone extends Node2D

## Referencia al enemigo.
@onready var enemy: BasicEnemy = $BasicEnemy

## Método llamado cuando la escena se inicializa.
func _ready():
	enemy.enemy_defeated.connect(_on_enemy_defeated)  ## Conecta la señal de enemigo derrotado.

## Función llamada cuando el enemigo es derrotado.
func _on_enemy_defeated():
	print("¡Has ganado la primera zona!")
	## Aquí puedes añadir lógica para avanzar a la siguiente zona.
