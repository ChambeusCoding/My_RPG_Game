extends Node2D

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animatedSprite.play("GrassEffect")
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		animatedSprite.play("GrassEffect")


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
