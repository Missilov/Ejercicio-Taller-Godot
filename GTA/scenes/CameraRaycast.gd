extends RayCast3D

var targetBuiliding:Node3D
var isFadingBuilding:bool = false

func _physics_process(delta: float) -> void:
	
	global_rotation = Vector3.ZERO
	target_position = $"../../Player".global_position - global_position
	
	if is_colliding() and not isFadingBuilding:
		targetBuiliding = get_collider()
		targetBuiliding.get_parent().toggleVisibility()
		isFadingBuilding = true
	elif not is_colliding() and isFadingBuilding:
		targetBuiliding.get_parent().toggleVisibility()
		isFadingBuilding = false
