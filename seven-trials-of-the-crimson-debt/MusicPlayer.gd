extends Node

var music: AudioStreamPlayer

func _ready():
	if not music:
		music = AudioStreamPlayer.new()
		add_child(music)
		music.stream = load("res://TestM.ogg")  # Replace with your music file path
		music.stream.loop = true  # Set the music to loop
		music.play()
