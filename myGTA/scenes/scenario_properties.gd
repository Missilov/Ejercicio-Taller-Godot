extends Node

const INITIAL_POLICE_AGENTS:int = 1
const THEFT_POLICE_FACTOR:int = 5

@export var maxCivilian:int = 10

var isDayTime:bool = true

var carQty:int = 0

var civilianQty:int = 0
var theftTimes:int = 0

var policeForce:int
var policeQty:int = 0
var policeKills:int = 0

var canSteal:bool = false

var playerRef:CharacterBody3D



func _init() -> void:
	policeForce = INITIAL_POLICE_AGENTS

func _process(delta: float) -> void:
	policeForce = INITIAL_POLICE_AGENTS + policeKills + int(theftTimes/THEFT_POLICE_FACTOR)

func get_tl_timer():
	return $TrafficLight_Timer

#func policeByThefts():
	#
	#if (theftTimes % THEFT_POLICE_FACTOR == 0):
		#return theftTimes / THEFT_POLICE_FACTOR

func resetValues():
	civilianQty = 0
	theftTimes = 0
	policeForce = INITIAL_POLICE_AGENTS
	policeQty = 0
	policeKills = 0
	carQty = 0
