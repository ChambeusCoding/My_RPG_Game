extends Control

# Adjust path to MusicManager (Autoload or Scene node)
@onready var music_manager = get_node_or_null("../MusicManager")  # Use if it's an Autoload
# If it's inside the scene, use: @onready var music_manager = get_node("../MusicManager")

# Adjust paths based on the correct hierarchy
@onready var enter_nexus_button: Button = %MarginContainer/VBoxContainer/EnterTheNexus
@onready var lay_in_between_button: Button = %MarginContainer/VBoxContainer/LayInTheInBetween
@onready var submit_will_button: Button = %MarginContainer/VBoxContainer/SubmitToDivineWill

@export var nexus_music: AudioStream
@export var in_between_music: AudioStream
@export var divine_will_music: AudioStream

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
	enter_nexus_button.pressed.connect(_on_enter_the_nexus_pressed)
	lay_in_between_button.pressed.connect(_on_lay_in_the_in_between_pressed)
	submit_will_button.pressed.connect(_on_submit_to_divine_will_pressed)

	# Connect hover signals for music switching
	enter_nexus_button.mouse_entered.connect(_on_enter_nexus_hover)
	lay_in_between_button.mouse_entered.connect(_on_lay_in_between_hover)
	submit_will_button.mouse_entered.connect(_on_submit_will_hover)

func _on_enter_the_nexus_pressed():
	get_tree().change_scene_to_file("res://world.tscn")

func _on_lay_in_the_in_between_pressed():
	pass  # Coming Soon

func _on_submit_to_divine_will_pressed():
	get_tree().quit()

# Hover Functions - Change music when hovering over options
func _on_enter_nexus_hover():
	if music_manager:
		music_manager.switch_music(nexus_music)

func _on_lay_in_between_hover():
	if music_manager:
		music_manager.switch_music(in_between_music)

func _on_submit_will_hover():
	if music_manager:
		music_manager.switch_music(divine_will_music)
