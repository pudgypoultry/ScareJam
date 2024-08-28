extends Area3D

class_name GrindableHandler
# pickupAndDrop

@export_category("Oil Production Properties")
@export var oilAmount = 10
@export var grindTime = 10

@export_category("Plugging in Nodes")
@export var collider : CollisionShape3D

var currentlyHolding = false

func PrepareMe(amount, time):
	oilAmount = amount
	grindTime = time

func CollectMe(player):
	player.grindableCount += 1
	queue_free()
