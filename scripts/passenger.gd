extends PathFollow2D

var enemy: bool = false
var shooting: bool = false
var timer_on: bool = false
var coef: float = 1.0

func _ready() -> void:
	if randi() % 100 < 70: # 70% probability
		enemy = true

func _physics_process(delta: float) -> void:
	var scalar = (progress_ratio) / 0.8 * 19 + 1
	progress_ratio += (0.01 + progress_ratio) * delta * 0.32 * coef
	scale = Vector2(scalar, scalar)
	
	if enemy and progress_ratio >= 0.2 and not timer_on:
		$Timer.wait_time = randi() % 4 + 1
		$Timer.start()
		timer_on = true
	
	if not $Walk.playing:
		$Walk.volume_db = progress_ratio * 10
		$Walk.play()
		
	if progress_ratio > 0.99:
		queue_free()



func _on_timer_timeout() -> void:
	$Timer.queue_free()
	$Area2D/Sprite.animation = "shooting"
	coef = 0


func _on_sprite_animation_finished() -> void:
	if $Area2D/Sprite.animation == "shooting":
		$Area2D/Sprite.animation = "walk"
		$Area2D/Sprite.speed_scale = 5
		$Area2D/Sprite.play()
		$Throw.play()
		coef = 5
		GlobalData.who_throw_snow.emit($Area2D/Marker2D.global_position, self.scale * 0.01)
		$Walk.pitch_scale = 4
