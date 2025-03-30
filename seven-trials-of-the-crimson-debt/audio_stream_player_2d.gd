extends Node

var music: AudioStreamPlayer

@export var default_music: AudioStream  # Default track when the game starts
@export var option1_music: AudioStream  # Music for Option 1
@export var option2_music: AudioStream  # Music for Option 2

func _ready():
	if not music:
		music = AudioStreamPlayer.new()
		add_child(music)
	
	# Set default music
	if default_music:
		music.stream = default_music
	else:
		music.stream = load("res://TestM.ogg")  # Fallback track

	music.stream.loop = true  # Set music to loop
	music.play()

func switch_music(new_track: AudioStream):
	if new_track and new_track != music.stream:  # Avoid restarting the same track
		music.stream = new_track
		music.play()
