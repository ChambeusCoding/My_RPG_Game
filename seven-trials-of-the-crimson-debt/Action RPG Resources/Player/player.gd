#extends CharacterBody2D
#
#@export var speed : float = 150.0
#@export var roll_speed : float = 100.0  # Increased speed for the roll
#@onready var animation_tree : AnimationTree = $AnimationTree
#
#
## Single Area2D node containing four CollisionShape2D child nodes
#@onready var hitbox : Area2D = $Hitbox
#@onready var right_hitbox : CollisionShape2D = $Hitbox/Right
#@onready var left_hitbox : CollisionShape2D = $Hitbox/Left
#@onready var forward_hitbox : CollisionShape2D = $Hitbox/Forward
#@onready var back_hitbox : CollisionShape2D = $Hitbox/Back
#
#var direction : Vector2 = Vector2.ZERO
#var last_direction : Vector2 = Vector2.ZERO  # Track last direction
#var roll_direction : Vector2 = Vector2.ZERO  # Direction of the roll
#var is_rolling : bool = false  # Track if roll animation is active
#
#var health = 100
#var health_max = 100
#var health_min = 0
#var dead: bool
#var can_take_damage: bool
#
#func _ready():
	## Connect the body_entered signal for each child hitbox to the handler function
	#hitbox.body_entered.connect(_on_hitbox_entered)
	##right_hitbox.body_entered.connect(_on_hitbox_entered)
	##left_hitbox.body_entered.connect(_on_hitbox_entered)
	##forward_hitbox.body_entered.connect(_on_hitbox_entered)
	##back_hitbox.body_entered.connect(_on_hitbox_entered)
#
	## Activate the animation tree
	#animation_tree.active = true
#
#func _process(_delta):
	## Update animation parameters
	#update_animation_parameters()
#
#func _physics_process(_delta):
	## Get the direction from input and normalize it
	#direction = Input.get_vector("left", "right", "up", "down").normalized()
#
	## Handle roll direction and velocity
	#if is_rolling:
		## Apply the roll speed in the roll direction
		#velocity = roll_direction * roll_speed
		#move_and_slide()  # Move with roll speed
	#elif direction != Vector2.ZERO:
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
		#roll_direction = direction  # Update roll direction
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
#
		## This function will be triggered when the body enters any of the collision areas (children of the Hurtbox node)
#func _on_hitbox_entered(body: Node) -> void:
	## Check if the body that entered the hitbox is a bat_phantom (enemy or entity)
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
		## Assuming the bat_phantom (enemy) node is the parent of the hurtbox node,
		## apply the knockback to the bat_phantom (enemy) node itself:
		#if body.get_parent():  # Check if the bat_phantom has a parent (the actual enemy object)
			#var enemy = body.get_parent()  # Get the bat_phantom (enemy) node
			#enemy.apply_impulse(Vector2.ZERO, knockback_vector)  # Apply the knockback to the enemy
			
extends CharacterBody2D

@export var speed : float = 150.0  # Normal walking speed
@export var sprint_speed : float = 225.0  # Sprinting speed (1.5x normal)
@export var roll_speed : float = 100.0  # Roll movement speed
@onready var animation_tree : AnimationTree = $AnimationTree

@onready var hitbox : Area2D = $Hitbox
@onready var right_hitbox : CollisionShape2D = $Hitbox/Right
@onready var left_hitbox : CollisionShape2D = $Hitbox/Left
@onready var forward_hitbox : CollisionShape2D = $Hitbox/Forward
@onready var back_hitbox : CollisionShape2D = $Hitbox/Back

var direction : Vector2 = Vector2.ZERO
var last_direction : Vector2 = Vector2.DOWN  # Default to downward facing
var roll_direction : Vector2 = Vector2.ZERO  # Direction of the roll
var is_rolling : bool = false  # Track if roll animation is active

func _ready():
	hitbox.body_entered.connect(_on_hitbox_entered)
	animation_tree.active = true

func _physics_process(_delta):
	# Get movement direction from input
	direction = Input.get_vector("left", "right", "up", "down").normalized()

	# Update `last_direction` **immediately** when movement starts
	if direction != Vector2.ZERO:
		last_direction = direction

	# Determine current speed (walk or sprint)
	var current_speed = sprint_speed if Input.is_action_pressed("sprint") else speed

	# Handle roll direction and velocity
	if is_rolling:
		velocity = roll_direction * roll_speed
	else:
		velocity = direction * current_speed

	move_and_slide()
	update_animation_parameters()

func update_animation_parameters():
	var is_moving = direction != Vector2.ZERO  # True if player is pressing movement keys
	var is_sprinting = is_moving and Input.is_action_pressed("sprint")

	# **Force update `blend_position` every frame** to prevent getting stuck
	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Walk/blend_position", last_direction)
	animation_tree.set("parameters/Swing/blend_position", last_direction)
	animation_tree.set("parameters/Roll/blend_position", last_direction)

	# Animation state handling
	animation_tree.set("parameters/conditions/idle", not is_moving)
	animation_tree.set("parameters/conditions/is_moving", is_moving and not is_sprinting)
	animation_tree.set("parameters/conditions/sprint", is_sprinting)

	# Attack animation
	if Input.is_action_just_pressed("attack"):
		animation_tree.set("parameters/conditions/swing", true)
	else:
		animation_tree.set("parameters/conditions/swing", false)

	# Roll animation
	if Input.is_action_just_pressed("roll") and not is_rolling:
		animation_tree.set("parameters/conditions/roll", true)
		is_rolling = true
		roll_direction = last_direction  # Roll follows last movement direction
	else:
		animation_tree.set("parameters/conditions/roll", false)
		is_rolling = false

# Handles hitbox interaction with enemies
func _on_hitbox_entered(body: Node) -> void:
	if body.is_in_group("bat_phantom"):
		var knockback_force = 120
		var knockback_vector : Vector2

		# Apply knockback based on which hitbox was triggered
		if body == right_hitbox:
			knockback_vector = Vector2(1, 0) * knockback_force
		elif body == left_hitbox:
			knockback_vector = Vector2(-1, 0) * knockback_force
		elif body == forward_hitbox:
			knockback_vector = Vector2(0, -1) * knockback_force
		elif body == back_hitbox:
			knockback_vector = Vector2(0, 1) * knockback_force

		# Apply knockback to the enemy
		if body.get_parent():
			var enemy = body.get_parent()
			enemy.apply_impulse(Vector2.ZERO, knockback_vector)
