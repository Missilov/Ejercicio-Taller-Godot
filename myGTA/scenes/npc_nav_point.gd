extends Node3D

const MIN_SPAWN_TIME:float = 5.0
const MAX_SPAWN_TIME:float = 20.0

@export var northAvailable:bool = true
@export var southAvailable:bool = true
@export var westAvailable:bool = true
@export var eastAvailable:bool = true

@export var northNavPoint:Node3D = null
@export var southNavPoint:Node3D = null
@export var westNavPoint:Node3D = null
@export var eastNavPoint:Node3D = null

@export var civilNPC:PackedScene = null
@export var policeNPC:PackedScene = null

var canSpawnNPC:bool = true


func spawnNPC(whereToGo):
	var newDirection:String = whereToGo
	var newCivilian = civilNPC.instantiate()
	match newDirection:
		"NORTH":
			newCivilian.nextNavPoint = northNavPoint
		"SOUTH":
			newCivilian.nextNavPoint = southNavPoint
		"WEST":
			newCivilian.nextNavPoint = westNavPoint
		"EAST":
			newCivilian.nextNavPoint = eastNavPoint
	$".".add_child(newCivilian)

func spawnPolice(whereToGo):
	var newDirection:String = whereToGo
	var newPolice = policeNPC.instantiate()
	match newDirection:
		"NORTH":
			newPolice.nextNavPoint = northNavPoint
		"SOUTH":
			newPolice.nextNavPoint = southNavPoint
		"WEST":
			newPolice.nextNavPoint = westNavPoint
		"EAST":
			newPolice.nextNavPoint = eastNavPoint
	$".".add_child(newPolice)

func directionNSWE():
	var dirResults:Array = ["NORTH","SOUTH","WEST","EAST"]
	var compass_NSWE:Array = [randi(),randi(),randi(),randi()]
	var strongestDir:int = 0
	
	if not northAvailable:
		compass_NSWE[0] *= 0
	if not southAvailable:
		compass_NSWE[1] *= 0
	if not westAvailable:
		compass_NSWE[2] *= 0
	if not eastAvailable:
		compass_NSWE[3] *= 0
	
	for i in compass_NSWE.size()-1:
		if compass_NSWE[strongestDir] < compass_NSWE[i+1]:
			strongestDir = i+1
	
	return dirResults[strongestDir]

func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	canSpawnNPC = false

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	canSpawnNPC = true

func _on_timer_timeout() -> void:
	if canSpawnNPC:
		if ScenarioProperties.policeQty < ScenarioProperties.policeForce:
			spawnPolice(directionNSWE())
			ScenarioProperties.policeQty += 1
		elif ScenarioProperties.civilianQty <= ScenarioProperties.maxCivilian:
			spawnNPC(directionNSWE())
			ScenarioProperties.civilianQty += 1
	$Timer.wait_time = randf_range(MIN_SPAWN_TIME,MAX_SPAWN_TIME)


func _on_npc_detector_body_entered(body: Node3D) -> void:
	var newDirection:String = directionNSWE()
	match newDirection:
		"NORTH":
			body.nextNavPoint = northNavPoint
		"SOUTH":
			body.nextNavPoint = southNavPoint
		"WEST":
			body.nextNavPoint = westNavPoint
		"EAST":
			body.nextNavPoint = eastNavPoint
		
