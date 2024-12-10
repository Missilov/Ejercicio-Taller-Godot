extends CharacterBody3D


const SPEED = 3.0
const JUMP_VELOCITY = 3.5
const SPRINT_VEL_ADD = 3.0
const TURN_MOD = 3.0

var isJumping:bool = false
var isRunning:bool = false
var sprintMod:float = 0.0
var angle:float = 0.0
var money:int = 0

func _ready() -> void:
	ScenarioProperties.playerRef = self

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		if (velocity.y >= 0):
			$Body/AnimationPlayer.play("jump")
		else:
			$Body/AnimationPlayer.play("fall")
		velocity += get_gravity() * delta
	else:
		isJumping = false
	
	if Input.is_action_just_pressed("JUMP_Key") and is_on_floor():
		isJumping = true
		$Body/AnimationPlayer.play("jump")
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("LEFT_Key", "RIGHT_Key", "UP_Key", "DOWN_Key")
	var direction := (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	angle -= input_dir.x
	rotation_degrees.y = angle * TURN_MOD
	if Input.is_action_pressed("SPRINT_Key") and Vector3(input_dir.x, 0, input_dir.y) != Vector3.ZERO:
		sprintMod = SPRINT_VEL_ADD
		isRunning = true
		if not isJumping:
			$Body/AnimationPlayer.play("sprint")
	else:
		sprintMod = 0.0
		isRunning = false
	if direction:
		if not isJumping and not isRunning:
			$Body/AnimationPlayer.play("walk")
		velocity.x = direction.x * (SPEED + sprintMod)
		velocity.z = direction.z * (SPEED + sprintMod)
	else:
		if not isJumping and not isRunning:
			$Body/AnimationPlayer.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_just_pressed("SHOOT_Key"):
		var bullet:Node3D = $AMMO.get_resource("bullet").instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = self.global_position
		bullet.global_rotation = self.global_rotation
	
	move_and_slide()


func _on_theft_area_body_entered(body: Node3D) -> void:
	money += body.money
	body.initDespawn()
	ScenarioProperties.theftTimes += 1
	


func _on_theft_area_body_exited(body: Node3D) -> void:
	pass
