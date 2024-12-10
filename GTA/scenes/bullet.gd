extends Node3D

const SPEED = 15

func _process(delta: float) -> void:
	translate(Vector3.FORWARD * SPEED * delta)

func _on_timer_timeout() -> void:
	queue_free()

func _on_general_area_body_entered(body: Node3D) -> void:
	print("Impacto en NO humano")
	#queue_free()

func _on_human_area_body_entered(body: Node3D) -> void:
	print("Impacto en humano")
	$BloodExplosion.emitting = true
	$BloodExplosion.reparent(body)
	body.ohNoImDead()
	ScenarioProperties.civilianQty -= 1
	queue_free()
