#extends Node2D
#
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("attack"):
		#var grassEffectScene = load("res://Action RPG Resources/Effects/grasseffect.tscn")
		#var grassEffect = grassEffectScene.instantiate()
		#var world = get_tree().current_scene
		#world.add_child(grassEffect)
		#queue_free()

extends Node2D

func create_grass_effect():
	var grassEffectScene = load("res://Action RPG Resources/Effects/grasseffect.tscn")
	var grassEffect = grassEffectScene.instantiate()
	var world = get_tree().current_scene
	world.add_child(grassEffect)
	grassEffect.global_position = global_position
		


func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
