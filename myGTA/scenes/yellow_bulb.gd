extends MeshInstance3D

@onready var Bulb2:StandardMaterial3D = self.get_surface_override_material(0)

func turnOn():
	Bulb2["emission_enabled"] = true

func turnOff():
	Bulb2["emission_enabled"] = false
