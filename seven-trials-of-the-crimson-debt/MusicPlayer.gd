#extends Node
#
## The music player
#var music: AudioStreamPlayer2D
#
## Exported music tracks
#@export var default_music: AudioStream  # Default track when the game starts
#@export var nexus_music: AudioStream  # Music for Enter the Nexus
#@export var in_between_music: AudioStream  # Music for Lay in the In-Between
#@export var divine_will_music: AudioStream  # Music for Submit to Divine Will
#
## Called when the singleton is loaded
#func _ready():
	## Create AudioStreamPlayer2D if it doesn't exist
	#if not music:
		#music = AudioStreamPlayer2D.new()
		#add_child(music)  # Add it as a child of the AudioManager (global)
#
	## Set default music
	#if default_music:
		#music.stream = default_music
	#else:
		#music.stream = load("res://TestM.ogg")  # Fallback track
	#
	#music.play()
#
## Function to switch the music track
#func switch_music(new_track: AudioStream):
	#if new_track and new_track != music.stream:
		#music.stop()  # Stop current music before switching
		#music.stream = new_track
		#music.play()

extends Node

var music: AudioStreamPlayer  # <-- Not 2D

@export var default_music: AudioStream
@export var nexus_music: AudioStream
@export var in_between_music: AudioStream
@export var divine_will_music: AudioStream

func _ready():
	if not music:
		var existing_player = get_node_or_null("AudioStreamPlayer2D")
		if existing_player:
			music = existing_player
		else:
			music = AudioStreamPlayer.new()
			music.name = "AudioStreamPlayer2D"
			add_child(music)

	# Stop anything playing first, just in case
	music.stop()
	
	# Set stream
	music.stream = default_music if default_music else load("res://audio/TestM8bit.ogg")
	music.play()

func switch_music(new_track: AudioStream):
	if new_track and new_track != music.stream:
		music.stop()
		music.stream = new_track
		music.play()
