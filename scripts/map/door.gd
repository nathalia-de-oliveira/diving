extends Area2D

var entered

func _process(_delta: float) -> void:
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			var level_control = get_parent().get_parent()
			var level_to_set = PLAYERSTATS.level + 1
			level_control.change_level(level_to_set)

func _on_body_entered(_body: PhysicsBody2D):
	entered = true
	
func _on_body_exited(_body: PhysicsBody2D):
	entered = false
