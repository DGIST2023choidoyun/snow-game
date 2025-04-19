extends Node

@onready var passenger_obj = preload("res://scenes/objects/passenger.tscn")
var cnt = 0

func _ready() -> void:
	GlobalData.game_start.connect($Timer.start)

func _on_timer_timeout() -> void:
	#await get_tree().create_timer(randi() % 5).timeout
	
	var random_path: Path2D = [$Path1, $Path2].pick_random()
	var passenger: PathFollow2D = load("res://scenes/objects/passenger.tscn").instantiate()
	if random_path == $Path2:
		passenger.get_child(0).scale.x = -1
	
	random_path.add_child(passenger)
	cnt += 1
	
	#if cnt % 10 == 0 and $Timer.wait_time > 1:
		#$Timer.wait_time -= 1
