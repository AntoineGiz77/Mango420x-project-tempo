extends CharacterBody2D

func animate_beat():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position:y", position.y - 10, 0.1)  # Salta un poco
	tween.tween_property(self, "position:y", position.y, 0.1)  # Vuelve a su lugar
