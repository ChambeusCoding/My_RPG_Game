extends Node2D

@export var sign_text: String = "Sign Text Here"
@onready var label: Label = $Label

var player_near: bool = false

func _ready():
	label.visible = false  # Hide text initially

func _process(delta):
	if player_near and Input.is_action_just_pressed("use"):  # "E" key interaction
		label.visible = !label.visible  # Toggle visibility

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):  # Ensure player is in "player" group
		player_near = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_near = false
		label.visible = false  # Hide text when the player leaves
