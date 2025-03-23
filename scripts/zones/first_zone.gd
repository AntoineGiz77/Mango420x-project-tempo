## Clase que maneja la lógica de la primera zona.
class_name FirstZone extends Node2D

## Referencia al EnemySpawner.
@onready var enemy_spawner: EnemySpawner = $EnemySpawner

## Referencia al ExitButton.
@onready var exit_button: ExitButton = $ExitButton

## Método llamado cuando la escena se inicializa.
func _ready():
	exit_button.exit_zone.connect(_on_exit_zone)  ## Conecta la señal de salida de la zona.

## Función llamada cuando el jugador decide salir de la zona.
func _on_exit_zone():
	print("Saliendo de la zona...")
	## Aquí puedes añadir lógica para cambiar de escena o mostrar un menú.

## Función llamada cuando el enemigo es derrotado.
func _on_enemy_defeated():
	print("¡Has ganado la primera zona!")
	## Aquí puedes añadir lógica para avanzar a la siguiente zona.
