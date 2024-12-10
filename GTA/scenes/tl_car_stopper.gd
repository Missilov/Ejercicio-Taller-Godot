extends Area3D

var hasToStop:bool = false
var targetCar:CharacterBody3D = null

func _process(delta: float) -> void:
	if hasToStop and targetCar != null:
		targetCar.isRunning = false
	elif not hasToStop and targetCar != null:
		targetCar.isRunning = true

func _on_body_entered(body: Node3D) -> void:
	targetCar = body

func _on_body_exited(body: Node3D) -> void:
	targetCar = null
