extends Node3D


@export var isGreen:bool = true
var TL_Timer:Timer = ScenarioProperties.get_tl_timer()


func _ready() -> void:
	TL_Timer.timeout.connect(on_change_tl_turn)
	on_change_tl_turn()

func greenTurn():
	$LightsBox/RedLight.turnOff()
	$LightsBox/YellowLight.turnOff()
	$LightsBox/GreenLight.turnOn()
	$CarStop.hasToStop = false
	await get_tree().create_timer(25.0).timeout
	$LightsBox/YellowLight.turnOn()
	$CarStop.hasToStop = true

func redTurn():
	$LightsBox/RedLight.turnOn()
	$LightsBox/YellowLight.turnOff()
	$LightsBox/GreenLight.turnOff()
	$CarStop.hasToStop = true

func on_change_tl_turn():
	isGreen = not isGreen
	if isGreen:
		greenTurn()
	else:
		redTurn()
