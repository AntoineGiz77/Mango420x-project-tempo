class_name BasicEnemy
extends CharacterBody2D

@export var max_health: int = 100  
@export var attack_damage: int = 10  

signal enemy_defeated

var current_health: int  

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	current_health = max_health  
	sprite.play("idle")  # Asegurar que empiece en idle

func take_damage(damage: int):
	current_health -= damage  
	print("Enemigo recibió ", damage, " de daño. Vida restante: ", current_health)

	if current_health > 0:
		sprite.play("hurt")  # Cambia la animación a daño
		await get_tree().create_timer(0.5).timeout  # Espera 0.5s para volver a idle
		sprite.play("idle")  
	else:
		die()  

func die():
	print("¡Enemigo derrotado!")
	sprite.play("death")  # Cambia la animación a muerte
	await get_tree().create_timer(0.5).timeout  # Espera a que termine la animación
	emit_signal("enemy_defeated")  
	queue_free()  
