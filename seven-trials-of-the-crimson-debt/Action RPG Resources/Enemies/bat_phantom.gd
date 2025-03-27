extends CharacterBody2D

var knockback = Vector2.ZERO
var health = 50
var health_max = 50
var health_min = 0
var dead = false
var taking_damage = false
var is_roaming: bool
var damage_to_deal = 10
var points_for_kill = 100


func _physics_process(delta):
	# Apply knockback force, moving it toward zero over time
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	
	# Set the velocity to the knockback value
	velocity = knockback  # Set knockback as the velocity
	
	# Move the character using the set velocity
	move_and_slide()  # Now, no argument is needed here in Godot 4

func _on_hurtbox_area_entered(area: Area2D) -> void:
	# Set knockback based on the hurtbox's knockback_vector
	knockback = area.knockback_vector * 120
