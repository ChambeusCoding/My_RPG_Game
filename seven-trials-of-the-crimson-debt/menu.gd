extends Control

func _on_enter_the_nexus_pressed() -> void:
	pass #COMING SOON

func _on_lay_in_the_in_between_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_submit_to_divine_will_pressed() -> void:
	get_tree().quit()
