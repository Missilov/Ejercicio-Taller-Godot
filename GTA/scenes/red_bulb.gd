extends MeshInstance3D

@onready var Bulb1:StandardMaterial3D = self.get_surface_override_material(0)

func turnOn():
	Bulb1["emission_enabled"] = true

func turnOff():
	Bulb1["emission_enabled"] = false
