extends TextureRect

var rotate_flag = false

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	rotate_flag = true
	
	var tween = create_tween()
	
	tween.tween_property(self, "scale", Vector2(0.4, 0.4), 1.25)
	tween.set_trans(Tween.TRANS_BOUNCE)
	
	await tween.finished
	
	rotate_flag = false
	
	animation_finished()

func _process(delta: float) -> void:
	if rotate_flag:
		rotation = lerp(rotation, deg_to_rad(1440), delta * 1.15)

func animation_finished():
	var tween = create_tween()
	
	tween.tween_property(self, "rotation", deg_to_rad(1070), 0.2)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	
	tween = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(1080), 0.3)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	await tween.finished
	
	await get_tree().create_timer(1).timeout
	
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 1.5)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)
	
	var tween2 = create_tween()
	tween2.tween_property(self, "position:y", 800, 3)
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_IN)

	await tween2.finished

	queue_free()
