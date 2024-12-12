extends MeshInstance3D

var isLocalDayTime:bool = false

func _ready() -> void:
	$AnimationPlayer.play("disabled")

func _process(delta: float) -> void:
	if ScenarioProperties.isDayTime and isLocalDayTime:
		$AnimationPlayer.play("turn_off")
		isLocalDayTime = not isLocalDayTime
	elif (not ScenarioProperties.isDayTime and not isLocalDayTime):
		$AnimationPlayer.play("turn_on")
		isLocalDayTime = not isLocalDayTime
