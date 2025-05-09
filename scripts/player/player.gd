extends CharacterBody2D

@onready var light_beam = $Visuals/PlayerLightBeam
@onready var animation_player = $Visuals/PlayerSprite
@onready var animation_effects = $Visuals/AnimationEffects
var animation_direction = "front"
var current_state = "idle"
var state_update

@export var MAX_SPEED = 30
@export var ACCELERATION = 10000
@export var FRICTION = 10000
@onready var axis = Vector2.ZERO
var previous_axis = Vector2.ZERO

func _ready():
	animation_player.stop()
	
func _physics_process(delta):
	
	if state_update == false:
		animation_effects.pause()
		if current_state == "atack": #The atack state duration is defined by the animation
			if animation_player.frame_progress == 1:
				state_update = true
	else:
		animation_effects.play("floating")
		player_state(delta)
	
func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up")) 
	
	return axis.normalized()

func movement(delta):
	
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
		
	move_and_slide()
	
func player_state(delta):
	
	get_direction()
	
	if Input.is_action_just_pressed("atackbutton"):
		current_state = "atack"
	elif axis == Vector2.ZERO:
		current_state = "idle"
	else:
		current_state = "move"
	
	var animation_to_play = animation_direction + "_" + current_state
	
	if current_state == "atack":
		state_update = false
		animation_player.play(animation_to_play)
	else:
		movement(delta)

	animation_player.play(animation_to_play)
		
func get_direction():
	
	axis = get_input_axis()
	
	if axis.x == 0 && axis.y != 0:
		if axis.y > 0:
			light_beam.rotation_degrees = 0
			animation_player.flip_h = false
			animation_direction = "front"
		if axis.y < 0:
			light_beam.rotation_degrees = 180
			animation_player.flip_h = false
			animation_direction = "back"
	if axis.y == 0 && axis.x != 0:
		if axis.x > 0:
			light_beam.rotation_degrees = 270
			animation_player.flip_h = true
			animation_direction = "side"
		if axis.x < 0:
			light_beam.rotation_degrees = 90
			animation_player.flip_h = false
			animation_direction = "side"
	if axis.x != 0 && axis.y != 0:
		if axis.y > 0: 
			if axis.x > 0:
				light_beam.rotation_degrees = 315
				animation_player.flip_h = true
				animation_direction = "digfront"
			if axis.x < 0:
				light_beam.rotation_degrees = 45
				animation_player.flip_h = false
				animation_direction = "digfront"
		if axis.y < 0:
			if axis.x > 0:
				light_beam.rotation_degrees = 225
				animation_player.flip_h = true
				animation_direction = "digback"
			if axis.x < 0:
				light_beam.rotation_degrees = 135
				animation_player.flip_h = false
				animation_direction = "digback"

#TODO: corrigir animações de ataque, as vezes é destro e às vezes canhotokkkkk
#TODO: Bug de iluminação: parte do sprite do player fica escuro quando está na parede 
