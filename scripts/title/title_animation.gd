extends Node

var can_touch: bool = false

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
	

func start():
	$PreGame.show()
	await get_tree().create_timer(1).timeout
	
	var tween = create_tween()
	tween.tween_property($PreGame/Newspaper, "scale", Vector2(2, 2), 0.4)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	await tween.finished

	can_touch = true

func _on_pre_game_gui_input(event: InputEvent) -> void:
	if can_touch and event.is_pressed():
		GlobalData.in_game = true
		GlobalData.game_start.emit()
		GlobalData.view_score.emit()
		self.queue_free()
		
