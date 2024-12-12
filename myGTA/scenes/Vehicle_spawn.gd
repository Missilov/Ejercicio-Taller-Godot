extends Marker3D

var TempCar:CharacterBody3D
var isFreeSpace:bool = true
@onready var carList:Array = $CarCatalogue.get_resource_list()

func InvokeCar():
	if isFreeSpace:
		var newCar = $CarCatalogue.get_resource(carList.pick_random())
		TempCar = newCar.instantiate()
		TempCar.global_transform = global_transform
		get_parent().add_child(TempCar)
		ScenarioProperties.carQty += 1

func _on_free_space_detector_body_entered(body: Node3D) -> void:
	isFreeSpace = false

func _on_free_space_detector_body_exited(body: Node3D) -> void:
	isFreeSpace = true
