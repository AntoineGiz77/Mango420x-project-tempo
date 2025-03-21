extends Node2D

signal beat  # Enviará una señal cada vez que haya un beat

func _ready():
	$BeatTimer.timeout.connect(_on_beat)

func _on_beat():
	print("¡Beat!")  # Para verificar que funciona
	$BeatSound.play()
	emit_signal("beat")  # Enviamos el beat a otros nodos
