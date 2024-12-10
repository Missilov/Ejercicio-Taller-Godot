extends MeshInstance3D

const HIDDEN_ALPHA:float = 0.4

var isHidden:bool = false
var buildingMat:StandardMaterial3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var matQty:int = get_surface_override_material_count()
	for i in matQty:
		var tempMat:StandardMaterial3D = get_surface_override_material(i)
		tempMat["albedo_color"].a = HIDDEN_ALPHA
		set_surface_override_material(i,tempMat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggleVisibility():
	if isHidden:
		isHidden = false
		alphaTexture()
	else:
		isHidden = true
		alphaTexture()

func alphaTexture():
	var matQty:int = get_surface_override_material_count()
	for i in matQty:
		var tempMat:StandardMaterial3D = get_surface_override_material(i)
		if isHidden:
			tempMat["transparency"]=BaseMaterial3D.TRANSPARENCY_ALPHA
		else:
			tempMat["transparency"]=BaseMaterial3D.TRANSPARENCY_DISABLED
		set_surface_override_material(i,tempMat)
