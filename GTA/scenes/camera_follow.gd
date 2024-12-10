extends Camera3D

func _process(delta: float) -> void:
	position.x = ScenarioProperties.playerRef.position.x
	position.z = ScenarioProperties.playerRef.position.z + 10
	
