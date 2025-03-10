extends Control

func renewEffectSound(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effect"), linear_to_db(value))
	$Panel/Base/Effect/Label.text = "{0}%".format([value * 100])

func renewBGMSound(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear_to_db(value))
	$Panel/Base/BGM/Label.text = "{0}%".format([value * 100])


func _on_panel_gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		$PauseButton.show()
		$Panel.hide()

func display():
	$Panel.show()
	$PauseButton.hide()
