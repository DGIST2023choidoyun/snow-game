extends Node2D

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Label, "position:y", -48, 0.5)
	
	await tween.finished
	
	queue_free()
