class_name Imp
extends BasicEnemy

func _init():
	max_health = 50  # Asegura que la vida se establezca antes de _ready()
	attack_damage = 5  

func _ready():
	super()  # Llama a la versión base de _ready() después de definir los valores  
	sprite.play("idle")
