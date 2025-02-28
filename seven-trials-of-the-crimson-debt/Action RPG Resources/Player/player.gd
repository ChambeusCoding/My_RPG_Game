#extends CharacterBody2D
#
#@export var speed : float = 150.0
#@onready var animation_tree : AnimationTree = $AnimationTree
#
#var direction : Vector2 = Vector2.ZERO
#var last_direction : Vector2 = Vector2.ZERO  # Track last direction
#
#func _ready():
	#animation_tree.active = true
#
#func _process(delta):
	#update_animation_parameters()
#
#func _physics_process(delta):
	## Get the direction from input and normalize it
	#direction = Input.get_vector("left", "right", "up", "down").normalized()
	#
	#if direction:
		#velocity = direction * speed
		#last_direction = direction  # Update last direction when moving
	#else:
		#velocity = Vector2.ZERO
	#
	## Apply the velocity by directly setting it on the CharacterBody2D
	#move_and_slide()  # move_and_slide() will now automatically use `velocity`
#
#func update_animation_parameters():
	#if velocity == Vector2.ZERO:
		## Character is idle, so set the blend_position to the last direction
		#animation_tree["parameters/conditions/idle"] = true
		#animation_tree["parameters/conditions/is_moving"] = false
		#
		## Don't update blend_position if the character is idle, just hold last direction
		#animation_tree["parameters/Idle/blend_position"] = last_direction
		#animation_tree["parameters/Walk/blend_position"] = last_direction
		#animation_tree["parameters/Swing/blend_position"] = last_direction
		#animation_tree["parameters/Roll/blend_position"] = last_direction
	#else:
		## Character is moving, reset idle parameters
		#animation_tree["parameters/conditions/idle"] = false
		#animation_tree["parameters/conditions/is_moving"] = true
		#
		## Update movement parameters with the current direction
		#animation_tree["parameters/Walk/blend_position"] = direction
		#animation_tree["parameters/Swing/blend_position"] = direction
		#animation_tree["parameters/Roll/blend_position"] = direction
#
	## Handle swing animation logic
	#if Input.is_action_just_pressed("attack"):
		#animation_tree["parameters/conditions/swing"] = true
	#else:
		#animation_tree["parameters/conditions/swing"] = false
		#
	#if Input.is_action_just_pressed("roll"):
		#animation_tree["parameters/conditions/roll"] = true
	#else:
		#animation_tree["parameters/conditions/roll"] = false
		





#####3#############




#extends CharacterBody2D
#
#@export var speed : float = 150.0
#@export var roll_speed : float = 500.0  # Increased speed for the roll
#@onready var animation_tree : AnimationTree = $AnimationTree
#@onready var swordHitBox = $Hurtbox
#
#var direction : Vector2 = Vector2.ZERO
#var last_direction : Vector2 = Vector2.ZERO  # Track last direction
#var roll_direction : Vector2 = Vector2.ZERO  # Direction of the roll
#var is_rolling : bool = false  # Track if roll animation is active
#
#func _ready():
	#animation_tree.active = true
	#swordHitBox.knockback_vector = roll_vector
#
#func _process(delta):
	#update_animation_parameters()
#
#func _physics_process(delta):
	## Get the direction from input and normalize it
	#direction = Input.get_vector("left", "right", "up", "down").normalized()
#
	## Handle roll direction and velocity
	#if is_rolling:
		## Apply the roll speed in the roll direction
		#velocity = roll_direction * roll_speed
		#move_and_slide()  # Move with roll speed
	#elif direction:
		## Apply normal walking velocity
		#velocity = direction * speed
		#last_direction = direction  # Update last direction when moving
		#move_and_slide()  # move_and_slide() will now automatically use `velocity`
	#else:
		#velocity = Vector2.ZERO
		#move_and_slide()
#
#func update_animation_parameters():
	## Idle state (no movement)
	#if velocity == Vector2.ZERO:
		#animation_tree.set("parameters/conditions/idle", true)
		#animation_tree.set("parameters/conditions/is_moving", false)
		#
		## Set blend position to last direction for idle
		#roll_vector = input_vector
		#swordHitBox.knockback_vector = input_vector
		#animation_tree.set("parameters/Idle/blend_position", last_direction)
		#animation_tree.set("parameters/Walk/blend_position", last_direction)
		#animation_tree.set("parameters/Swing/blend_position", last_direction)
		#animation_tree.set("parameters/Roll/blend_position", last_direction)
#
		## Reset roll animation if idle
		#animation_tree.set("parameters/conditions/roll", false)
		#is_rolling = false
	#else:
		## Moving state
		#animation_tree.set("parameters/conditions/idle", false)
		#animation_tree.set("parameters/conditions/is_moving", true)
		#
		## Update blend position to current direction
		#animation_tree.set("parameters/Walk/blend_position", direction)
		#animation_tree.set("parameters/Swing/blend_position", direction)
		#animation_tree.set("parameters/Roll/blend_position", direction)
#
	## Handle swing animation logic
	#if Input.is_action_just_pressed("attack"):
		#animation_tree.set("parameters/conditions/swing", true)
	#else:
		#animation_tree.set("parameters/conditions/swing", false)
#
	## Handle roll animation logic
	#if Input.is_action_just_pressed("roll") and not is_rolling:
		## Start roll animation
		#animation_tree.set("parameters/conditions/roll", true)
		#is_rolling = true
		#
		## Set roll direction (same as current movement direction, if any)
		#roll_direction = direction if direction != Vector2.ZERO else last_direction
	#else:
		## Cancel roll and transition back to walking if roll is done or direction changes
		#if is_rolling:
			#animation_tree.set("parameters/conditions/roll", false)
			#is_rolling = false
#
		## Transition back to walking if not rolling
		#if velocity != Vector2.ZERO and not is_rolling:
			#animation_tree.set("parameters/conditions/roll", false)
			#animation_tree.set("parameters/conditions/is_moving", true)
			
			
			
extends CharacterBody2D

@export var speed : float = 150.0
@export var roll_speed : float = 500.0  # Increased speed for the roll
@onready var animation_tree : AnimationTree = $AnimationTree

# Single Area2D node containing four CollisionShape2D child nodes
@onready var hitbox : Area2D = $Hitbox
@onready var right_hitbox : CollisionShape2D = $Hitbox/Right
@onready var left_hitbox : CollisionShape2D = $Hitbox/Left
@onready var forward_hitbox : CollisionShape2D = $Hitbox/Forward
@onready var back_hitbox : CollisionShape2D = $Hitbox/Back

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.ZERO  # Track last direction
var roll_direction : Vector2 = Vector2.ZERO  # Direction of the roll
var is_rolling : bool = false  # Track if roll animation is active

func _ready():
	# Connect the body_entered signal for each child hitbox to the handler function
	hitbox.body_entered.connect(_on_hitbox_entered)
	#right_hitbox.body_entered.connect(_on_hitbox_entered)
	#left_hitbox.body_entered.connect(_on_hitbox_entered)
	#forward_hitbox.body_entered.connect(_on_hitbox_entered)
	#back_hitbox.body_entered.connect(_on_hitbox_entered)

	# Activate the animation tree
	animation_tree.active = true

func _process(_delta):
	# Update animation parameters
	update_animation_parameters()

func _physics_process(_delta):
	# Get the direction from input and normalize it
	direction = Input.get_vector("left", "right", "up", "down").normalized()

	# Handle roll direction and velocity
	if is_rolling:
		# Apply the roll speed in the roll direction
		velocity = roll_direction * roll_speed
		move_and_slide()  # Move with roll speed
	elif direction != Vector2.ZERO:
		# Apply normal walking velocity
		velocity = direction * speed
		last_direction = direction  # Update last direction when moving
		move_and_slide()  # move_and_slide() will now automatically use `velocity`
	else:
		velocity = Vector2.ZERO
		move_and_slide()

func update_animation_parameters():
	# Idle state (no movement)
	if velocity == Vector2.ZERO:
		animation_tree.set("parameters/conditions/idle", true)
		animation_tree.set("parameters/conditions/is_moving", false)
		
		# Set blend position to last direction for idle
		roll_direction = direction  # Update roll direction
		animation_tree.set("parameters/Idle/blend_position", last_direction)
		animation_tree.set("parameters/Walk/blend_position", last_direction)
		animation_tree.set("parameters/Swing/blend_position", last_direction)
		animation_tree.set("parameters/Roll/blend_position", last_direction)

		# Reset roll animation if idle
		animation_tree.set("parameters/conditions/roll", false)
		is_rolling = false
	else:
		# Moving state
		animation_tree.set("parameters/conditions/idle", false)
		animation_tree.set("parameters/conditions/is_moving", true)
		
		# Update blend position to current direction
		animation_tree.set("parameters/Walk/blend_position", direction)
		animation_tree.set("parameters/Swing/blend_position", direction)
		animation_tree.set("parameters/Roll/blend_position", direction)

	# Handle swing animation logic
	if Input.is_action_just_pressed("attack"):
		animation_tree.set("parameters/conditions/swing", true)
	else:
		animation_tree.set("parameters/conditions/swing", false)

	# Handle roll animation logic
	if Input.is_action_just_pressed("roll") and not is_rolling:
		# Start roll animation
		animation_tree.set("parameters/conditions/roll", true)
		is_rolling = true
		
		# Set roll direction (same as current movement direction, if any)
		roll_direction = direction if direction != Vector2.ZERO else last_direction
	else:
		# Cancel roll and transition back to walking if roll is done or direction changes
		if is_rolling:
			animation_tree.set("parameters/conditions/roll", false)
			is_rolling = false

		# Transition back to walking if not rolling
		if velocity != Vector2.ZERO and not is_rolling:
			animation_tree.set("parameters/conditions/roll", false)
			animation_tree.set("parameters/conditions/is_moving", true)

## This function will be triggered when the body enters any of the collision areas (children of the Hitbox node)
#func _on_hitbox_entered(body: Node) -> void:
	## Check if the body that entered the hitbox is the player (or any other entity you want to apply knockback to)
	#if body.is_in_group("bat_phantom"):
		## Determine the knockback vector based on which hitbox was entered
		#var knockback_force = 120  # Adjust as needed
		#var knockback_vector : Vector2
#
		## Apply different knockback based on which collision area was triggered
		#if body == right_hitbox:
			#knockback_vector = Vector2(1, 0) * knockback_force  # Knockback to the right
		#elif body == left_hitbox:
			#knockback_vector = Vector2(-1, 0) * knockback_force  # Knockback to the left
		#elif body == forward_hitbox:
			#knockback_vector = Vector2(0, -1) * knockback_force  # Knockback forward (up)
		#elif body == back_hitbox:
			#knockback_vector = Vector2(0, 1) * knockback_force  # Knockback backward (down)
#
		## Apply the knockback impulse
		#body.apply_impulse(Vector2.ZERO, knockback_vector)  # Apply the knockback to the player
		
		# This function will be triggered when the body enters any of the collision areas (children of the Hurtbox node)
func _on_hitbox_entered(body: Node) -> void:
	# Check if the body that entered the hitbox is a bat_phantom (enemy or entity)
	if body.is_in_group("bat_phantom"):
		# Determine the knockback vector based on which hitbox was entered
		var knockback_force = 120  # Adjust as needed
		var knockback_vector : Vector2

		# Apply different knockback based on which collision area was triggered
		if body == right_hitbox:
			knockback_vector = Vector2(1, 0) * knockback_force  # Knockback to the right
		elif body == left_hitbox:
			knockback_vector = Vector2(-1, 0) * knockback_force  # Knockback to the left
		elif body == forward_hitbox:
			knockback_vector = Vector2(0, -1) * knockback_force  # Knockback forward (up)
		elif body == back_hitbox:
			knockback_vector = Vector2(0, 1) * knockback_force  # Knockback backward (down)

		# Assuming the bat_phantom (enemy) node is the parent of the hurtbox node,
		# apply the knockback to the bat_phantom (enemy) node itself:
		if body.get_parent():  # Check if the bat_phantom has a parent (the actual enemy object)
			var enemy = body.get_parent()  # Get the bat_phantom (enemy) node
			enemy.apply_impulse(Vector2.ZERO, knockback_vector)  # Apply the knockback to the enemy
