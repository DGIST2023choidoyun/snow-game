extends Area2D



func throw(pos):
	pos = clamp(pos, Vector2(pos.x, 208), Vector2(pos.x, 448))
	var height = 250 + (pos.y - 448) / 2
	var i_proj_scale = (448 - pos.y) / 500
	var f_proj_scale = (448 - pos.y) / 1000
	
	var tween = create_tween()
	var scale_tween = create_tween()
	tween.tween_property(self, "position", pos - Vector2(0, height), 0.2)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	scale_tween.tween_property(self, "scale", Vector2(i_proj_scale, i_proj_scale), 0.2)
	scale_tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	
	await tween.finished
	
	tween = create_tween()
	tween.tween_property(self, "position", pos, 0.1)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN)
	
	scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2(f_proj_scale, f_proj_scale), 0.1)
	scale_tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	await tween.finished
	
	monitoring = true
	$Sprite2D.texture = null
	
	await get_tree().create_timer(0.6).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Passenger"):
		area.get_parent().queue_free()
		if area.get_parent().enemy and area.get_child(0).animation == "shooting":
			GlobalData.score = GlobalData.score + 1
			GlobalData.view_score.emit()
		else:
			GlobalData.score = GlobalData.score - 1
			GlobalData.view_score.emit()
		#$Hit.play()
		#$Hit.finished.connect($Hit.queue_free)
		#$Hit.reparent(get_tree().root)
