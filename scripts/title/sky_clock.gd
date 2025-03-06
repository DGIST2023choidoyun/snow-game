extends ColorRect

var phase = 0 # 0: morning, 1: afternoon, 2: night
const sky_color = [0xaaccffff, 0xffdde1ff, 0x223355ff]

func _on_timer_timeout() -> void:
	phase += 1
	if phase > 2:
		phase = 0
	
	var tween = create_tween()
	tween.tween_property(self, "color", Color(sky_color[phase]), 2.5)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	var earth_tween = create_tween()
	earth_tween.tween_property($BG/ColorRect, "color", Color(sky_color[phase] - 0x000000ff + 0x0000007f), 2.5)
	earth_tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	await tween.finished
