extends Control

# Adjust path to AudioManager (Autoload or Scene node)
@onready var audio_manager = get_node_or_null("/root/AudioStreamPlayer2D")  # Assuming AudioManager is an Autoload node or in the root

# Adjust paths based on the correct hierarchy
@onready var enter_nexus_button: Button = $MarginContainer/VBoxContainer/EnterTheNexus
@onready var lay_in_between_button: Button = $MarginContainer/VBoxContainer/LayInTheIIBetween
@onready var submit_will_button: Button = $MarginContainer/VBoxContainer/SubmitToDivineWill

@export var nexus_music: AudioStream  # Music for the Nexus world
@export var nexus_scene: String  # Path to the Nexus world scene (e.g., "res://scenes/world.tscn")

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

	# Connect menu button signals
	enter_nexus_button.connect("pressed", self, "_on_enter_nexus_pressed")
	lay_in_between_button.connect("pressed", self, "_on_lay_in_between_pressed")
	submit_will_button.connect("pressed", self, "_on_submit_will_pressed")

# Button press handlers
func _on_enter_nexus_pressed():
	# Switch music to the Nexus track when this button is pressed
	if audio_manager:
		audio_manager.switch_music(nexus_music)
	
	# Load the Nexus world scene
	if nexus_scene != "":
		get_tree().change_scene(nexus_scene)

func _on_lay_in_between_pressed():
	# This button does nothing as per the request
	pass

func _on_submit_will_pressed():
	# Exit the game when this button is pressed
	get_tree().quit()
