extends Node

var bg
var dir: int = 0 # -1, 0, 1

var snowball_gauge: int = 0
var snowball_charging: bool = false
var snowball_hold: bool = false

@onready var snowball_obj = preload("res://scenes/objects/snow_ball.tscn")

func _ready() -> void:
	bg = get_tree().get_nodes_in_group("background")[0]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Head Up"):
		dir = -1
	elif event.is_action_pressed("Head Down"):
		dir = 1
	elif event.is_action_released("Head Up") or event.is_action_released("Head Down"):
		dir = 0
	
	if not snowball_hold:
		if event.is_action_pressed("Charge"):
			snowball_charging = true
		elif event.is_action_released("Charge"):
			snowball_charging = false

func _process(delta: float) -> void:
	if snowball_charging:
		$SnowballProgress.value += delta * 30
		if $SnowballProgress.value >= 100:
			snowball_hold = true
			snowball_charging = false
			$SnowballProgress.value = 0
			
			var snowball = snowball_obj.instantiate()
			get_tree().root.add_child(snowball)
			snowball.global_position = $SnowballProgress/Marker2D.global_position
	else:
		$SnowballProgress.value -= delta * 60

func _physics_process(delta: float) -> void:
	var yy = bg.position.y
	if dir > 0: # head up
		bg.position.y -= delta * 6 * (yy + 900)
		if yy < -900:
			dir = 0
			bg.position.y = -900
	elif dir < 0: # head down
		bg.position.y += delta * 6 * (-yy)
		if yy > 0:
			dir = 0
			bg.position.y = 0
	if dir != 0:
		bg.scale =Vector2(1 - yy / 1400, 1 - yy / 1400)
		
