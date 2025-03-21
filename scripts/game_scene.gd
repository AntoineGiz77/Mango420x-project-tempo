extends Node2D

signal beat # Señal del beat

var waiting_for_input = false  # Si estamos esperando el input del jugador
var input_timer = 0.0  # Controlador para el intervalo de espera entre beats

func _ready():
	$BeatTimer.wait_time = 0.50  # 120 BPM (0.50 segundos)
	$BeatTimer.timeout.connect(_on_beat)  # Conectar al evento de beat
	$BeatTimer.start()  # Iniciar el temporizador

	$BeatSound.play()  # Reproducir el metrónomo inmediatamente cuando inicie el juego

func _on_beat():
	$BeatSound.play()  # Reproducir el sonido del beat cada vez que pase un ciclo
	emit_signal("beat")  # Emitir la señal "beat" para que los otros nodos reaccionen
	waiting_for_input = true  # Ahora estamos esperando una entrada del jugador

func _process(delta):
	# Solo permitimos la entrada en el momento adecuado
	if waiting_for_input:
		# Detectar los inputs de las teclas
		if Input.is_action_just_pressed("ui_up"):  # Si el jugador presiona la tecla Arriba
			$InputSound.play()  # Reproducir el sonido sutil (nota)
			waiting_for_input = false  # Dejar de esperar la entrada

		elif Input.is_action_just_pressed("ui_down"):  # Si el jugador presiona la tecla Abajo
			$InputSound.play()  # Reproducir el sonido sutil
			waiting_for_input = false  # Dejar de esperar la entrada

		elif Input.is_action_just_pressed("ui_left"):  # Si el jugador presiona la tecla Izquierda
			$InputSound.play()  # Reproducir el sonido sutil
			waiting_for_input = false  # Dejar de esperar la entrada

		elif Input.is_action_just_pressed("ui_right"):  # Si el jugador presiona la tecla Derecha
			$InputSound.play()  # Reproducir el sonido sutil
			waiting_for_input = false  # Dejar de esperar la entrada

	# Reiniciar el esperando por la entrada después de un ciclo de beat
	if !waiting_for_input:
		waiting_for_input = false  # Evitar que se repita indefinidamente
