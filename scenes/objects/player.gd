extends Node

var bg
var dir: int = 0 # -1, 0, 1

func _ready() -> void:
	bg = get_tree().get_nodes_in_group("background")[0]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Head Up"):
		dir = -1
	elif event.is_action_pressed("Head Down"):
		dir = 1
	elif event.is_action_released("Head Up") or event.is_action_released("Head Down"):
		dir = 0

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
		
