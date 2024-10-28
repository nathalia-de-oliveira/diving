extends Area2D

var entered = false

func _on_body_entered(_body: Node2D):
	entered = true
	
func _on_body_exited(_body: Node2D):
	entered = false
	
func _process(_delta):
	if entered == true:
		if Input.is_action_just_pressed("shift"):
			print("mudar de room")
