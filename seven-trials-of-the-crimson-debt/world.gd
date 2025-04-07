extends Node2D

const CHUNK_SIZE = 512
const LOAD_RADIUS = 2
const CHUNK_PATH = "res://chunks/chunk_%d_%d.tscn"

var loaded_chunks = {}
var player_ref

func _ready():
	player_ref = $Player  # Adjust path to your actual player node

func _process(delta):
	var player_chunk = Vector2(
		floor(player_ref.global_position.x / CHUNK_SIZE),
		floor(player_ref.global_position.y / CHUNK_SIZE)
	)

	var chunks_to_keep = {}

	# Loop through all chunks within the load radius
	for x_offset in range(-LOAD_RADIUS, LOAD_RADIUS + 1):
		for y_offset in range(-LOAD_RADIUS, LOAD_RADIUS + 1):
			var chunk_pos = player_chunk + Vector2(x_offset, y_offset)
			var key = str(chunk_pos.x) + "_" + str(chunk_pos.y)

			if not loaded_chunks.has(key):
				var path = CHUNK_PATH % [int(chunk_pos.x), int(chunk_pos.y)]

				# Use ResourceLoader to check if the scene exists
				if ResourceLoader.exists(path):  # Check if the resource exists
					var scene = ResourceLoader.load(path) as PackedScene
					if scene:  # Ensure the scene is valid
						var chunk = scene.instantiate()  # Create a chunk instance
						chunk.position = chunk_pos * CHUNK_SIZE  # Position the chunk correctly
						add_child(chunk)  # Add it to the scene
						loaded_chunks[key] = chunk  # Store the chunk in the loaded dictionary

			chunks_to_keep[key] = true

	# Unload chunks that are no longer needed
	for key in loaded_chunks.keys():
		if not chunks_to_keep.has(key):
			loaded_chunks[key].queue_free()  # Free the chunk
			loaded_chunks.erase(key)  # Remove from the dictionary
