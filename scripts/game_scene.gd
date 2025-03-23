## Clase principal que maneja el ritmo y la interacción del jugador.
class_name GameScene extends Node2D

## Señal emitida en cada beat.
signal beat  

@export var waiting_for_input = false
@export var input_timer = 0.0
@export var rhythm_manager: RhythmManager
@export var rhythm_feedback: RhythmFeedback
@export var enemy_spawner: EnemySpawner

var current_enemy : BasicEnemy = null
var can_attack: bool = true

## Inicialización de la escena y conexión de señales.
func _ready():
	$BeatTimer.wait_time = 0.50
	$BeatTimer.timeout.connect(_on_beat)
	$BeatTimer.start()
	$BeatSound.play()
	
	rhythm_manager.perfect_input.connect(_on_perfect_input)
	rhythm_manager.good_input.connect(_on_good_input)
	rhythm_manager.bad_input.connect(_on_bad_input)
	
	if enemy_spawner:
		enemy_spawner.enemy_spawned.connect(_on_enemy_spawned)
		enemy_spawner.generating_enemy.connect(_on_generating_enemy)

## Manejo del beat: activa el sonido y espera input.
func _on_beat():
	$BeatSound.play()
	emit_signal("beat")
	waiting_for_input = true
	rhythm_manager.register_beat()

## Captura de inputs del jugador.
func _process(_delta):
	if can_attack and waiting_for_input:
		for dir in ["up", "down", "left", "right"]:
			if Input.is_action_just_pressed("ui_" + dir):
				_input_correct(dir)

func _on_generating_enemy():
	can_attack = false

func _on_enemy_spawned(enemy: BasicEnemy):
	current_enemy = enemy
	can_attack = true

## Evalúa la precisión del input y aplica daño.
func _input_correct(direction: String):
	if can_attack:
		$ArmyController.jump_units(direction)
		var evaluation = rhythm_manager.evaluate_input(direction)
		if current_enemy:
			var damage = 20 if evaluation == "perfect" else 10 if evaluation == "good" else 0
			current_enemy.take_damage(damage)
		$InputSound.play()
		waiting_for_input = false

## Feedback visual y sonoro según la precisión del input.
func _on_perfect_input(_direction: String):
	rhythm_feedback.show_feedback("perfect")
	$PerfectSound.play()

func _on_good_input(_direction: String):
	rhythm_feedback.show_feedback("good")
	$InputSound.play()

func _on_bad_input(_direction: String):
	rhythm_feedback.show_feedback("bad")
	$BadSound.play()
