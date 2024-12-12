extends CharacterBody3D

const WALK_SPEED:float = 2.0
const SPRINT_SPEED_MOD:float = 2.5


var nextNavPoint:Node3D = null
var tempSkin:Node3D
var speedMOD:float = 1
var isDead:bool = false
var npcDodging:bool = false
var money:int = randi_range(1,100)
var robbed:bool = false
var hasToDespawn:bool = false
var canDespawn:bool = false


func _ready() -> void:

	var SkinList:Array = $SkinCatalogue.get_resource_list()
	var newSkin:PackedScene = $SkinCatalogue.get_resource(SkinList.pick_random())
	tempSkin = newSkin.instantiate()
	tempSkin.position.y -= 0.5
	add_child(tempSkin)


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
	global_rotation.y = 0
	look_at_from_position(global_position,nextNavPoint.global_position,Vector3.UP)
	rotation.x = 0
	rotation.z = 0
	translate(Vector3.FORWARD * WALK_SPEED * delta * speedMOD)
	if npcDodging:
		translate(Vector3.RIGHT * WALK_SPEED/2 * delta * speedMOD)
	if speedMOD != 0.0:
		tempSkin.get_child(1).play("walk")
	move_and_slide()
	if hasToDespawn and canDespawn:
		queue_free()
		ScenarioProperties.civilianQty -= 1


func ohNoImDead ():

	if not isDead:
		isDead = true
		speedMOD = 0
		tempSkin.get_child(1).play("die")
		await get_tree().create_timer(3).timeout
		queue_free()
		ScenarioProperties.civilianQty -= 1

func initDespawn():
	money = 0
	robbed = true
	$Despawn_Timer.start()

func _on_area_3d_body_entered(body: Node3D) -> void:

	if body != self:
		npcDodging = true


func _on_area_3d_body_exited(body: Node3D) -> void:

	if body != self:
		npcDodging = false


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	canDespawn = true


func _on_despawn_timer_timeout() -> void:
	hasToDespawn = true
