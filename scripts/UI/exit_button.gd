## Clase que maneja el botón para salir de la zona.
class_name ExitButton extends Button

## Señal emitida cuando el jugador decide salir de la zona.
signal exit_zone

## Método llamado cuando la escena se inicializa.
func _ready():
	pressed.connect(_on_pressed)  ## Conecta la señal de botón presionado.

## Función llamada cuando el botón es presionado.
func _on_pressed():
	emit_signal("exit_zone")  ## Notifica que el jugador quiere salir de la zona.
