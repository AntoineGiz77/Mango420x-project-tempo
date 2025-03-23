extends "res://scripts/enemies/basic_enemy.gd"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D  # Referencia al sprite animado

func _ready():
	super()
	sprite.play("idle")  # Inicia en animación de idle

func take_damage(damage: int):
	super(damage)
	sprite.play("hurt")
	await get_tree().create_timer(0.2).timeout  # Espera un poco antes de volver a idle
	sprite.play("idle")

func die():
	sprite.play("death")
	await sprite.animation_finished
	super()
