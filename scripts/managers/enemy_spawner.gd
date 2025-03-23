## Clase encargada de generar enemigos.
class_name EnemySpawner extends Node2D

signal generating_enemy
signal enemy_spawned(enemy: BasicEnemy)

@export var enemy_scene: PackedScene
@export var spawn_delay: float = 2.0

@onready var spawn_position: Marker2D = $SpawnPosition
var current_enemy: BasicEnemy = null

func _ready():
	$Timer.wait_time = spawn_delay
	$Timer.timeout.connect(_on_timer_timeout)
	call_deferred("spawn_enemy")

func _on_timer_timeout():
	if current_enemy == null:
		spawn_enemy()

## Genera y posiciona un nuevo enemigo.
func spawn_enemy():
	emit_signal("generating_enemy")
	var enemy = enemy_scene.instantiate()
	if enemy is BasicEnemy:
		enemy.position = spawn_position.position
		add_child(enemy)
		enemy.enemy_defeated.connect(_on_enemy_defeated)
		current_enemy = enemy
		emit_signal("enemy_spawned", enemy)

func _on_enemy_defeated():
	current_enemy = null
	$Timer.start()
