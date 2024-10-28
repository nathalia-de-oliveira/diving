extends CharacterBody2D


#hi 

@onready var animation_player = $animated_player_sprite

var player_place = "wet"
var animation_direction = "front"
var animation_state = "idle"

@export var MAX_SPEED = 30
@export var ACCELERATION = 300
@export var FRICTION = 150

@onready var axis = Vector2.ZERO
var previous_axis = Vector2.ZERO

func _ready():
	animation_player.stop()

func _physics_process(delta):
	movement(delta)
	
func get_input_axis():
	
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")) 
	
	return axis.normalized()
	
func movement(delta):
	
	axis = get_input_axis()
	
	if axis.y == 1:
		animation_player.flip_h = false
		animation_direction = "front"
	if axis.y == -1:
		animation_player.flip_h = false
		animation_direction = "back"
	if axis.x > 0:
		animation_player.flip_h = true
		animation_direction = "side"
	if axis.x < 0:
		animation_player.flip_h = false
		animation_direction = "side"
		
	if axis == Vector2.ZERO:
		var accel = FRICTION * delta
		if velocity.length() > accel:
			velocity -= velocity.normalized() * accel
		else:
			velocity = Vector2.ZERO
	else:
		var accel = axis * ACCELERATION * delta
		velocity += accel
		velocity = velocity.limit_length(MAX_SPEED)
		
	if velocity.x != 0 or velocity.y != 0:
		animation_state = "move"
	else:
		animation_state = "idle"
	
	var animation_to_play = player_place + "_" + animation_direction + "_" + animation_state
	animation_player.play(animation_to_play)
	
	move_and_slide()
