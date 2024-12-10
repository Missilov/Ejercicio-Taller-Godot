extends Node3D

const SUN_ROTATION_VELOCITY:float = 0.05
const LIGHTS_ON_TIME:float = -2.1
const LIGHTS_OFF_TIME:float = 0.9
const LIGHT_TOGGLE_RANGE:float = 0.005
const MAX_VEHICLE_QTY:int = 20

@onready var CarSpawners:Array[Node] = $VehicleSpawners.get_children()


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	$DirectionalLight3D.rotate_z(SUN_ROTATION_VELOCITY * delta)
	if($DirectionalLight3D.rotation.z >= LIGHTS_ON_TIME - LIGHT_TOGGLE_RANGE and $DirectionalLight3D.rotation.z <= LIGHTS_ON_TIME + LIGHT_TOGGLE_RANGE):
		ScenarioProperties.isDayTime = false
		
	elif($DirectionalLight3D.rotation.z >= LIGHTS_OFF_TIME - LIGHT_TOGGLE_RANGE and $DirectionalLight3D.rotation.z <= LIGHTS_OFF_TIME + LIGHT_TOGGLE_RANGE):
		ScenarioProperties.isDayTime = true
	$Dialogue.text = "Dinero robado: %s $" % $Player.money



func _on_vehicle_spawn_timer_timeout() -> void:
	var temp:int = randi_range(0,11)
	if ScenarioProperties.carQty < MAX_VEHICLE_QTY:
		CarSpawners[temp].InvokeCar()


func _on_police_area_entered(body: Node3D) -> void:
	$Dialogue.text = "¡Hey, tu! ¡Alto ahí! Identificación..."


func _on_police_area_exited(body: Node3D) -> void:
	$Dialogue.text = ""
