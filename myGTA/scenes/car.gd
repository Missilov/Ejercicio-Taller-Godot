extends CharacterBody3D

const SPEED:float = -6.0
const STUCKTIME:float = 60.0

@export var currentTimeDay:bool = true

var isRunning:bool = true
var isBlocked:bool = false
var stopped:bool = false

func _ready():
	turnBreakLightsOFF()
	turnHeadLightsOFF()
	if not ScenarioProperties.isDayTime:
		turnBreakLightsON()
		turnHeadlightsON()

func _physics_process(delta: float) -> void:
	
	if not isBlocked and isRunning:
		translate(Vector3.FORWARD * SPEED * delta)
		turnBreakLightsOFF()
	else:
		velocity = Vector3.ZERO
		turnBreakLightsON()
	
	move_and_slide()
	
	if velocity.is_zero_approx() and not stopped and isRunning and not isBlocked:
		$StuckTimer.start(STUCKTIME)
		stopped = true
	elif not velocity.is_zero_approx() and stopped:
		$StuckTimer.stop()
		stopped = false

func _process(delta: float) -> void:
	if ScenarioProperties.isDayTime and not currentTimeDay: # Si en ScenarioProperties se hace de dia y en el frame anterior del coche era de noche
		currentTimeDay = true
		turnHeadLightsOFF()
	elif (not ScenarioProperties.isDayTime and currentTimeDay):
		currentTimeDay = false
		turnHeadlightsON()

func turnHeadlightsON():
	var L_HeadlightBulb:StandardMaterial3D = $Illumination/Left_Headlight.get_surface_override_material(0)
	var R_HeadlightBulb:StandardMaterial3D = $Illumination/Right_Headlight.get_surface_override_material(0)

	L_HeadlightBulb["emission_enabled"] = true
	R_HeadlightBulb["emission_enabled"] = true
	$Illumination/LeftLight.visible = true
	$Illumination/RightLight.visible = true

func turnHeadLightsOFF():
	var L_HeadlightBulb:StandardMaterial3D = $Illumination/Left_Headlight.get_surface_override_material(0)
	var R_HeadlightBulb:StandardMaterial3D = $Illumination/Right_Headlight.get_surface_override_material(0)

	L_HeadlightBulb["emission_enabled"] = false
	R_HeadlightBulb["emission_enabled"] = false
	$Illumination/LeftLight.visible = false
	$Illumination/RightLight.visible = false

func turnBreakLightsON():
	var L_BreakBulb:StandardMaterial3D = $Illumination/BackLeft_Light.get_surface_override_material(0)
	var R_BreakBulb:StandardMaterial3D = $Illumination/BackRight_Light.get_surface_override_material(0)
	
	L_BreakBulb["emission_enabled"] = true
	R_BreakBulb["emission_enabled"] = true

func turnBreakLightsOFF():
	var L_BreakBulb:StandardMaterial3D = $Illumination/BackLeft_Light.get_surface_override_material(0)
	var R_BreakBulb:StandardMaterial3D = $Illumination/BackRight_Light.get_surface_override_material(0)
	
	L_BreakBulb["emission_enabled"] = false
	R_BreakBulb["emission_enabled"] = false

func _on_front_detector_body_entered(body: Node3D) -> void:
	if (body != self):
		isBlocked = true

func _on_front_detector_body_exited(body: Node3D) -> void:
	if (body != self):
		isBlocked = false

func _on_stuck_timer_timeout() -> void:
	ScenarioProperties.carQty -= 1
	queue_free()
