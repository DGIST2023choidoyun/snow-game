extends Node

func _ready() -> void:
	var scenes = load("res://scenes/main.tscn").instantiate()
	add_child(scenes)
