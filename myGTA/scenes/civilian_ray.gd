extends RayCast3D

func _physics_process(delta: float) -> void:
	
	global_rotation = Vector3.ZERO
	target_position = $"..".nextNavPoint.global_position - global_position
