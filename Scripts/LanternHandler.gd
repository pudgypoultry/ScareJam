extends Interactable

class_name LanternHandler

@export_category("Light Qualities")
@export var lightIntensity : float = 3:
	set(value):
		lightIntensity = value
	get:
		return lightIntensity
@export var lightRange : float = 10:
	set(value):
		lightRange = value
	get:
		return lightRange
@export var lightDropOffRate : float = 0.1:
	set(value):
		lightDropOffRate = value
	get:
		return lightDropOffRate

var lightEnergyMax : float:
	set(value):
		lightEnergyMax = value
	get:
		return lightEnergyMax

@export_category("Plugging In Objects")
@export var lanternLight : Array[OmniLight3D]
@export var lanternPickup : Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	lightEnergyMax = lanternLight[0].omni_range


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handleLight(delta)


func handleLight(delta):
	if holding:
		for light in lanternLight:
			light.omni_range -= (lightDropOffRate / 100)
	else:
		for light in lanternLight:
			light.omni_range -= (lightDropOffRate / 300)


func refillLight(amount : float):
	for light in lanternLight:
		if light.omni_range < lightEnergyMax:
			light.omni_range += amount
			print_debug(light.omni_range)

func handleCollision(mode : bool):
	lanternPickup.disabled = mode
