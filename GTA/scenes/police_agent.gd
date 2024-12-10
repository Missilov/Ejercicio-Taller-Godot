extends CharacterBody3D

const WALK_SPEED:float = 2.5
const SPRINT_SPEED:float = 5.0

var nextNavPoint:Node3D = null
var speedMOD:float = 1
var isDead:bool = false
var npcDodging:bool = false
var isOnPursuit:bool = false
var money:int = 0

@onready var playerNode:CharacterBody3D = ScenarioProperties.playerRef

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	global_rotation.y = 0
	if not isOnPursuit:
		look_at_from_position(global_position,nextNavPoint.global_position,Vector3.UP)
	elif isOnPursuit and not isDead:
		look_at(playerNode.position,Vector3.UP)
	rotation.x = 0
	rotation.z = 0
	if not isOnPursuit:
		translate(Vector3.FORWARD * WALK_SPEED * delta * speedMOD)
	else:
		translate(Vector3.FORWARD * SPRINT_SPEED * delta * speedMOD)
	if npcDodging:
		translate(Vector3.RIGHT * WALK_SPEED/2 * delta * speedMOD)
	if speedMOD != 0.0:
		if isOnPursuit:
			$Body/AnimationPlayer.play("sprint")
		else:
			$Body/AnimationPlayer.play("walk")
	move_and_slide()
	
func _on_area_3d_body_entered(body: Node3D) -> void:
	isOnPursuit = true

func ohNoImDead():
	if not isDead:
		isDead = true
		speedMOD = 0
		$Body/AnimationPlayer.play("die")
		await get_tree().create_timer(3).timeout
		queue_free()
		ScenarioProperties.policeQty -= 1
		ScenarioProperties.policeKills += 1

func initDespawn():
	pass

func _on_dodge_area_body_entered(body: Node3D) -> void:
	if body != self:
		npcDodging = true

func _on_dodge_area_body_exited(body: Node3D) -> void:
	if body != self:
		npcDodging = true


func _on_bust_area_body_entered(body: Node3D) -> void:
	if body == ScenarioProperties.playerRef and not isDead:
		ScenarioProperties.resetValues()
		get_tree().change_scene_to_file("res://scenes/busted_menu.tscn")
