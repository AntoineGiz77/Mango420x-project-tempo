## Clase que maneja el feedback visual para los inputs del jugador.
## Muestra una textura diferente según si el input fue perfecto, bueno o malo.
class_name RhythmFeedback extends CanvasLayer

## Propiedades exportadas para asignar las texturas de feedback.
@export var perfect_texture: Texture2D  # Textura para un input perfecto.
@export var good_texture: Texture2D     # Textura para un input bueno.
@export var bad_texture: Texture2D      # Textura para un input malo.

## Referencia al Sprite2D que mostrará el feedback.
@onready var feedback_sprite: Sprite2D = $FeedbackSprite

## Función para mostrar el feedback visual.
## Recibe el tipo de feedback ("perfect", "good", "bad") y muestra la textura correspondiente.
func show_feedback(feedback_type: String):
	match feedback_type:
		"perfect":
			feedback_sprite.texture = perfect_texture  # Asigna la textura para un input perfecto.
		"good":
			feedback_sprite.texture = good_texture     # Asigna la textura para un input bueno.
		"bad":
			feedback_sprite.texture = bad_texture      # Asigna la textura para un input malo.
	
	feedback_sprite.visible = true  # Hace visible el feedback.
	await get_tree().create_timer(0.5).timeout  # Muestra el feedback durante 0.5 segundos.
	feedback_sprite.visible = false  # Oculta el feedback después del tiempo.
