extends Control

# Adjust path to AudioManager (Autoload or Scene node)
@onready var audio_manager = get_node_or_null("/root/AudioStreamPlayer2D")  # Assuming AudioManager is an Autoload node or in the root

# Adjust paths based on the correct hierarchy
@onready var enter_nexus_button: Button = $MarginContainer/VBoxContainer/EnterTheNexus
@onready var lay_in_between_button: Button = $MarginContainer/VBoxContainer/LayInTheIIBetween
@onready var submit_will_button: Button = $MarginContainer/VBoxContainer/SubmitToDivineWill

@export var nexus_music: AudioStream  # Music for the Nexus world
@export var nexus_scene: String = "res://world.tscn"  # Path to the Nexus world scene (e.g., "res://scenes/world.tscn")

# Called when the scene is ready
func _ready():
	# Validate if buttons exist
	if not enter_nexus_button:
		push_error("EnterTheNexus button not found! Check scene tree paths.")
		return
	if not lay_in_between_button:
		push_error("LayInTheInBetween button not found! Check scene tree paths.")
		return
	if not submit_will_button:
		push_error("SubmitToDivineWill button not found! Check scene tree paths.")
		return
		
func _on_enter_the_nexus_pressed() -> void:
	if audio_manager and nexus_music:
		audio_manager.stream = nexus_music
		audio_manager.play()

	if nexus_scene != "":
		get_tree().change_scene_to_file(nexus_scene)
		

func _on_lay_in_the_ii_between_pressed() -> void:
	pass # Replace with function body.


func _on_submit_to_divine_will_pressed() -> void:
	get_tree().quit()
