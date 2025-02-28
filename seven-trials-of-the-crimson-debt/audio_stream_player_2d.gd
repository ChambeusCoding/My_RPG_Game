extends Node

var music_player : AudioStreamPlayer

func _ready():
	# Access the AudioStreamPlayer node as a child of this node
	music_player = $BackgroundMusic as AudioStreamPlayer  # Use the correct name of the AudioStreamPlayer node
	
	# Check if the music_player is correctly assigned
	if music_player:
		# Set the music to loop
		music_player.stream_loop = true
		
		# Start playing the music
		music_player.play()
	else:
		print("AudioStreamPlayer node not found!")
		
		print(get_node("/root/World"))
