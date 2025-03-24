# Clase base para todas las unidades del juego.
class_name Unit
extends Node2D

@export var health: int = 100  # Vida inicial de la unidad
@export var attack_damage: int = 10  # Daño de ataque
@export var attack_range: float = 100.0  # Rango de ataque
@export var attack_speed: float = 1.0  # Velocidad de ataque
@export var attack_cooldown: float = 1.0  # Enfriamiento del ataque (tiempo entre ataques)

var current_health: int  # Vida actual de la unidad

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# Función que se llama cuando la unidad entra en la escena
func _ready():
	current_health = health  # Inicializa la vida actual de la unidad.
	sprite.play("idle")  # Asegurar que empiece en idle

# Función que reduce la vida de la unidad cuando recibe daño.
func take_damage(damage: int):
	current_health -= damage  # Resta la cantidad de daño a la vida actual.
	if current_health <= 0:
		die()  # Si la vida llega a 0, la unidad muere.

# Función que maneja la muerte de la unidad.
func die():
	sprite.play("death")  # Cambia la animación a muerte
	await get_tree().create_timer(0.5).timeout  # Espera a que termine la animación
	emit_signal("enemy_defeated")  
	queue_free()  

# Función que maneja el ataque de la unidad. Esta se sobreescribirá en las subclases.
func attack():
	pass
