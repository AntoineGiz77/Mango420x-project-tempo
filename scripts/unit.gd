extends Node2D

@export var jump_height: float = 50.0  # Altura del salto
@export var jump_speed: float = 10.0   # Velocidad del salto
var velocity: float = 0.0  # Velocidad del salto (para simular gravedad)
var on_ground: bool = true  # Indica si la unidad está en el suelo

func _ready():
	velocity = 0.0
	on_ground = true

# Este método hará que la unidad salte hacia arriba y luego vuelva hacia abajo
func jump():
	if on_ground:
		velocity = -jump_speed  # Aplica una velocidad negativa para moverla hacia arriba
		on_ground = false

func _process(delta):
	if not on_ground:
		velocity += 1.0  # Simula la gravedad (aumenta la velocidad hacia abajo)
		position.y += velocity  # Aplica el cambio de velocidad al movimiento vertical

		if position.y >= 200:  # Cuando la unidad vuelve al "suelo"
			position.y = 200  # Posiciona la unidad en la altura de inicio
			velocity = 0.0  # Detiene la caída
			on_ground = true  # La unidad vuelve a estar en el suelo
