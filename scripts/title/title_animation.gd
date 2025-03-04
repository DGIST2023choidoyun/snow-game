extends Node

func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	
	var tween = create_tween()
	
	tween.tween_property($Title, "self_modulate:a", 1, 3)
	await tween.finished
	await get_tree().create_timer(1.5).timeout
	
	
	tween = create_tween()
	
	tween.tween_property($Title, "self_modulate:a", 0, 1.5)
	await tween.finished
	await get_tree().create_timer(1).timeout
	
	$Buttons.show()
	tween = create_tween()
	
	tween.tween_property($Buttons, "modulate:a", 1, 1.5)
	await tween.finished
	
