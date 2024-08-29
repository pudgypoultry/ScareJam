extends Node3D

class_name LanternHandler

@export_category("Tooltip")
@export var tooltipText : String = "(E) to pick up the Gaslit Lantern\n(F) to drop it back on the ground"

@export_category("Positioning")
@export var placementOffset : float = 0.0
@export var rotationOffset : Vector3 = Vector3(0, -163.4, 0)
@export var scaleOffset : Vector3 = Vector3(0.242, 0.242, 0.242)

@export_category("Lantern Qualities")
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
@export var holding = true

@export_category("Plugging In Objects")
@export var lanternLight : Array[OmniLight3D]
@export var lanternPickup : StaticBody3D
@export var holdingRay : RayCast3D
@export var collisionNode : CollisionShape3D

var previousRate : float

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


func PickupAndDrop(handPosition : Node3D):
	if holding:
		reparent(holdingRay.get_collider())
		global_position = holdingRay.get_collision_point() + Vector3(0, placementOffset, 0)
		holding = false
		collisionNode.set_disabled(false)
		print_debug(self.name, " should be enabled now")
	
	else:
		reparent(handPosition, false)
		position = Vector3.ZERO
		rotation = rotationOffset
		scale = scaleOffset
		holding = true
		collisionNode.set_disabled(true)
		print_debug(self.name, " should be disabled now")

func PauseLight():
	previousRate = lightDropOffRate
	lightDropOffRate = 0

func ResumeLight():
	lightDropOffRate = previousRate
