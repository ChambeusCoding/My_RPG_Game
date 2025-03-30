extends TextureRect

var player: Node  # Reference to the player
var map_visible := false  # Renamed to avoid conflict

func _ready():
	visible = false  # Start with the map hidden
	player = get_tree().get_first_node_in_group("/root/MiniGame/Player")  # Find player in group

	if not player:
		print_debug("Player not found! Make sure it's in the 'player' group.")

func _input(event):
	if event.is_action_pressed("Map"):
		map_visible = !map_visible
		visible = map_visible
		get_tree().paused = map_visible  # Pause/unpause the game

		if map_visible:
			center_map_on_player()  # Center the map when opening

func center_map_on_player():
	if player:
		var screen_center = get_viewport_rect().size / 2
		var map_position = -player.global_position + screen_center
		global_position = map_position  # Moves the map so the player is centered
