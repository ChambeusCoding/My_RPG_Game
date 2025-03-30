extends Node

@onready var music: AudioStreamPlayer = $MusicManager  # Use an existing AudioStreamPlayer node

@export var default_music: AudioStream  # Default track when the game starts
@export var nexus_music: AudioStream  # Music for Enter the Nexus
@export var in_between_music: AudioStream  # Music for Lay in the In-Between
@export var divine_will_music: AudioStream  # Music for Submit to Divine Will

func _ready():
	if not music:
		push_error("AudioStreamPlayer not found in MusicManager! Make sure it's in the scene.")
		return
	
	# Set default music
	if default_music:
		music.stream = default_music
	else:
		music.stream = load("res://TestM.ogg")  # Fallback track
	
	music.play()

func switch_music(new_track: AudioStream):
	if new_track and new_track != music.stream:
		music.stop()  # Stop current music before switching
		music.stream = new_track
		music.play()
