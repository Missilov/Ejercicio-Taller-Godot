extends MeshInstance3D

@onready var Bulb3:StandardMaterial3D = self.get_surface_override_material(0)

func turnOn():
	Bulb3["emission_enabled"] = true

func turnOff():
	Bulb3["emission_enabled"] = false
