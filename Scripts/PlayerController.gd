extends CharacterBody3D

@export_group("Health Management")
@export var baseHP : float = 10:
	set (value):
		baseHP = value
	get:
		return baseHP
@export var currentHP : float:
	set (value):
		currentHP = value
	get:
		return currentHP
var isDead : bool:
	get:
		return isDead
var isNearLight : bool:
	set (value):
		isNearLight = value
	get:
		return isNearLight

@export_group("Resource Management")
@export var grindableCount : int:
	set(value):
		grindableCount = value
	get:
		return grindableCount
@export var currentOilReward : float:
	set(value):
		currentOilReward = value
	get:
		return currentOilReward
@export var currentOilFillTime : float:
	set(value):
		currentOilReward = value
	get:
		return currentOilReward

@export_group("Horizontal Movement")
@export var playerSpeed : float = 10

@export_group("Camera Handling")
@export var camSpeedX : float = 0.5
@export var camSpeedY : float = 0.5
@export var verticalCameraClamp : float = 40

@export_group("Plugging In Objects")
@export var lanternLight : OmniLight3D
@export var lanternObject : LanternHandler
@export var holdingPosition : Node3D
@export var grindableHoldingPosition : Node3D
@export var axeObject : AxeHandler

@export_group("Collision Management")
@export var collectingRay : RayCast3D

@export_group("NodePaths")
@export var camPath : NodePath
@onready var cam : Camera3D = get_node(camPath)

var cameraX : float = 0.0
var cameraY : float = 0.0

var moveDirection : Vector3 = Vector3.ZERO
var holdingLantern = false
var debugCounter = 0
var canAct : bool = true
var inspecting : bool = false
var currentInspectable : InspectableHandler


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	currentHP = baseHP
	currentOilReward = 5
	currentOilFillTime = 1
	verticalCameraClamp = deg_to_rad(verticalCameraClamp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	moveDirection = Vector3.ZERO

	Movin(delta)
	Collectin()
	HandleInspectable()
	move_and_slide()
	CheckLight()
	
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN



func _input(event):         
	Rotation(event)


func DamageMe(damageAmount : float):
	print_debug("I've been hit for ", damageAmount, " damage!")
	currentHP -= damageAmount
	if (currentHP < 0):
		KillMe()


func KillMe():
	print_debug("I should be dead")


func Movin(delta):
	if canAct:
		if Input.is_action_pressed("Forward"):
			moveDirection += -basis.z
		if Input.is_action_pressed("Backward"):
			moveDirection += basis.z
		if Input.is_action_pressed("StrafeLeft"):
			moveDirection += -basis.x
		if Input.is_action_pressed("StrafeRight"):
			moveDirection += basis.x
	
	moveDirection = moveDirection.normalized()
	
	velocity = moveDirection * playerSpeed + Vector3(0, velocity.y, 0)


func Rotation(event):
	if event is InputEventMouseMotion && canAct:
		cameraX -= deg_to_rad(camSpeedX * event.relative.x)
		cameraY -= deg_to_rad(camSpeedY * event.relative.y)
		cameraY = clampf(cameraY, -verticalCameraClamp, verticalCameraClamp)
		cam.set_rotation(Vector3(cameraY, cam.rotation.y, cam.rotation.z))
		set_rotation(Vector3(rotation.x, cameraX, rotation.z))


func Collectin():
	if canAct:
		# If I am not holding the lantern and I'm trying to pick up something
		if Input.is_action_just_pressed("PickUp") && collectingRay.is_colliding() && !holdingLantern:
			var currentCollision = collectingRay.get_collider()
			print(currentCollision)
			# If that something is the lantern, pick it up
			if currentCollision.is_in_group("Lantern"):
				print("I AM OVER HERE")
				axeObject.PutAway()
				HoldPlayerInput(0.7)
				await get_tree().create_timer(0.7, true).timeout
				lanternObject.PickupAndDrop(holdingPosition)
				holdingLantern = true
				return
			
			# If that something is a breakable, chop it
			if currentCollision.is_in_group("Breakable"):
				axeObject.Chop()
				HoldPlayerInput(1.4)
				await get_tree().create_timer(1.3, true).timeout
				currentCollision.BreakMe()
				print("Ready to pick up again")
				return
		
		# If I am trying to interact with anything at all
		if Input.is_action_just_pressed("PickUp") && collectingRay.is_colliding():
			var currentCollision = collectingRay.get_collider()
			
			# If that something is fuel for the lantern, fuel the lantern
			if holdingLantern && currentCollision.is_in_group("LanternFuel"):
					currentCollision.CollectMe(lanternObject)
					return
			
			# If I have more than 0 grindable objects in my inventory, and if that object is the mill, grind a thing
			if grindableCount > 0:
				if currentCollision.is_in_group("MillGrinder"):
					#if !currentCollision.currentlySpawned:
					# Grind it up baybeeeeee
					grindableCount -= 1
					currentCollision.TakeInMaterial(currentOilReward, currentOilFillTime)
					print("Grindables: ", grindableCount)
					return
			
			# If that object is something that is grindable, pick it up
			if currentCollision.is_in_group("Grindable"):
				# Pick up the item that can be ground up
				currentCollision.CollectMe(self)
				print_debug("Collected a grindable: ", grindableCount)
				return
		
		if Input.is_action_just_pressed("Drop") && !collectingRay.is_colliding() && holdingLantern:
			lanternObject.PickupAndDrop(holdingPosition)
			holdingLantern = false
			axeObject.Equip()


func HandleInspectable():
	if Input.is_action_just_pressed("PickUp") && collectingRay.is_colliding():
		var currentCollision = collectingRay.get_collider()
		if currentCollision.is_in_group("Inspectable") && !inspecting:
			# Hold action until done
			canAct = false
			inspecting = true
			# Display UI item and blur screen behind UI item
			currentInspectable = currentCollision
			currentInspectable.InspectMe()
	
	if Input.is_action_just_pressed("Drop") && inspecting:
		# Put away UI Item and unblur screen behind UI
		currentInspectable.IgnoreMe()
		inspecting = false
		canAct = true


func CheckLight():
	# Check if I'm within the current range of the lantern light.
	isNearLight = (position.distance_to(lanternLight.position) < lanternLight.omni_range)


func HoldPlayerInput(howLong : float):
	canAct = false
	await get_tree().create_timer(howLong, true).timeout
	canAct = true
