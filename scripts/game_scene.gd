## Clase que maneja los eventos de ritmo del juego y las entradas del jugador.
## En esta clase se gestiona el temporizador de los beats y la entrada del jugador.
## Se conecta con el "ArmyController" para hacer saltar las unidades en el momento correcto.
class_name GameScene extends Node2D

## Señal emitida en cada ciclo de beat.
signal beat  

## Propiedades

@export var waiting_for_input = false  ## Si estamos esperando la entrada del jugador (true/false).
@export var input_timer = 0.0  ## Temporizador que controla el intervalo entre beats.

## Método llamado cuando la escena se inicializa.
## Este método configura el temporizador y comienza el sonido del metrónomo.
func _ready():
	$BeatTimer.wait_time = 0.50  ## 120 BPM (0.50 segundos entre beats).
	$BeatTimer.timeout.connect(_on_beat)  ## Conecta el evento del temporizador con la función _on_beat.
	$BeatTimer.start()  ## Inicia el temporizador para marcar los beats.

	$BeatSound.play()  ## Reproduce el sonido del metrónomo al inicio del juego.

## Método que se ejecuta cada vez que ocurre un beat (según el temporizador).
## Reproduce el sonido del beat y emite una señal para que otros nodos reaccionen.
## También marca que estamos esperando la entrada del jugador.
func _on_beat():
	$BeatSound.play()  ## Reproducir el sonido del beat.
	emit_signal("beat")  ## Emite la señal "beat" para que otros nodos puedan reaccionar.
	waiting_for_input = true  ## Comienza a esperar una entrada del jugador.

## Este método se ejecuta en cada frame.
## Aquí se detectan las teclas presionadas y, si estamos esperando una entrada,
## se llama a la función _input_correct() con la dirección de la tecla presionada.
func _process(_delta):
	# Solo detectamos entradas si estamos esperando una acción del jugador.
	if waiting_for_input:
		if Input.is_action_just_pressed("ui_up"):  ## Si se presiona la tecla Arriba.
			_input_correct("up")  ## Llama a la función de salto para esa dirección.
		elif Input.is_action_just_pressed("ui_down"):  ## Si se presiona la tecla Abajo.
			_input_correct("down")
		elif Input.is_action_just_pressed("ui_left"):  ## Si se presiona la tecla Izquierda.
			_input_correct("left")
		elif Input.is_action_just_pressed("ui_right"):  ## Si se presiona la tecla Derecha.
			_input_correct("right")

## Esta función se ejecuta cuando el jugador presiona una tecla correctamente.
## Llama al ArmyController para hacer saltar las unidades.
## También reproduce el sonido sutil y marca que ya no se espera una nueva entrada.
func _input_correct(direction: String):
	# Obtiene el nodo "ArmyController" para manipular las unidades.
	var army_controller = get_node("/root/GameScene/ArmyController")  ## Asegúrate de que la ruta sea correcta.
	army_controller.jump_units(direction)  ## Llama a la función de salto de las unidades en el controlador.

	$InputSound.play()  ## Reproduce el sonido sutil (nota) cuando se hace una entrada correcta.
	waiting_for_input = false  ## Termina de esperar la entrada.
