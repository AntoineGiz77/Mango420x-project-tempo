## Clase que maneja la evaluación de la precisión de los inputs del jugador.
## Aquí se definen los márgenes de tiempo para determinar si un input es perfecto, bueno o malo.
class_name RhythmManager extends Node

## Señales emitidas según la precisión del input.
signal perfect_input(direction: String)  # Se emite cuando el input es perfecto.
signal good_input(direction: String)     # Se emite cuando el input es bueno.
signal bad_input(direction: String)      # Se emite cuando el input es malo.

## Propiedades exportadas para ajustar los márgenes de tiempo.
@export var perfect_margin: float = 0.25 # ±250 ms para un input perfecto.
@export var good_margin: float = 0.5    # ±500 ms para un input bueno.

## Variable interna para almacenar el momento exacto del último beat.
var last_beat_time: float = 0.0

## Función para registrar el momento exacto del último beat.
## Esta función debe llamarse cada vez que ocurre un beat.
func register_beat():
	last_beat_time = Time.get_ticks_msec() / 1000.0  # Guarda el tiempo actual en segundos.

## Función para evaluar la precisión del input.
## Recibe la dirección del input y emite la señal correspondiente según el margen de tiempo.
func evaluate_input(direction: String):
	var current_time = Time.get_ticks_msec() / 1000.0  # Tiempo actual en segundos.
	var time_since_beat = abs(current_time - last_beat_time)  # Diferencia con el último beat.

	if time_since_beat <= perfect_margin:
		perfect_input.emit(direction)  # Input perfecto.
	elif time_since_beat <= good_margin:
		good_input.emit(direction)  # Input bueno.
	else:
		bad_input.emit(direction)  # Input malo.
