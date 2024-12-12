extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_pressed("UP_Key"):
		if Input.is_action_pressed("RIGHT_Key"):
			rotation.y = 3*PI/4
		elif Input.is_action_pressed("LEFT_Key"):
			rotation.y = -3*PI/4
		else:
			rotation.y = PI
	elif Input.is_action_pressed("DOWN_Key"):
		if Input.is_action_pressed("RIGHT_Key"):
			rotation.y = PI/4
		elif Input.is_action_pressed("LEFT_Key"):
			rotation.y = -PI/4
		else:
			rotation.y = 0
	else:
		if Input.is_action_pressed("RIGHT_Key"):
			rotation.y = PI/2
		elif Input.is_action_pressed("LEFT_Key"):
			rotation.y = -PI/2
