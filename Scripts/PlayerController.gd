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
		
@export_group("Horizontal Movement")
@export var playerSpeed : float = 10

@export_group("Camera Handling")
@export var camSpeedX : float = 0.5
@export var camSpeedY : float = 0.5
@export var verticalCameraClamp : float = 40

@export_group("Plugging In Objects")
@export var collectingRay : RayCast3D
@export var lanternLight : OmniLight3D
@export var lanternObject : LanternHandler
@export var holdingPosition : Node3D

'''
@export var currentGun : Node3D
@export var doubleJumpRay : RayCast3D
@export var gunPosition : Node3D
'''

@export_group("Collision Management")

@export_group("NodePaths")
@export var camPath : NodePath
@onready var cam : Camera3D = get_node(camPath)

var cameraX : float = 0.0
var cameraY : float = 0.0

var moveDirection : Vector3 = Vector3.ZERO
var holdingLantern = true
var debugCounter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	currentHP = baseHP
	verticalCameraClamp = deg_to_rad(verticalCameraClamp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	moveDirection = Vector3.ZERO

	Movin(delta)
	Collectin()
	move_and_slide()
	CheckLight()
	
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE



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
	if event is InputEventMouseMotion:
		cameraX -= deg_to_rad(camSpeedX * event.relative.x)
		cameraY -= deg_to_rad(camSpeedY * event.relative.y)
		cameraY = clampf(cameraY, -verticalCameraClamp, verticalCameraClamp)
		cam.set_rotation(Vector3(cameraY, cam.rotation.y, cam.rotation.z))
		set_rotation(Vector3(rotation.x, cameraX, rotation.z))


func Collectin():
	# print_debug(collectingRay.is_colliding(), collectingRay.get_collider())
	if Input.is_action_just_pressed("PickUp") && collectingRay.is_colliding():
		if collectingRay.get_collider() == lanternObject.collisionArea && !holdingLantern:
			lanternObject.pickupAndDrop(holdingPosition)
			holdingLantern = true
		
		elif collectingRay.get_collider().is_in_group("Collectable") && !holdingLantern:
			collectingRay.get_collider().CollectMe(self)
	
	if Input.is_action_just_pressed("PickUp") && collectingRay.is_colliding() && holdingLantern:
		pass
	
	if Input.is_action_just_pressed("Drop") && holdingLantern:
		lanternObject.pickupAndDrop(holdingPosition)
		holdingLantern = false


func CheckLight():
	# Check if I'm within the current range of the lantern light.
	isNearLight = (position.distance_to(lanternLight.position) < lanternLight.omni_range)
	
	'''
	if debugCounter > 10:
		print_debug("Within Light: ", isNearLight)
		print_debug("Holding Lantern: ", holdingLantern)
		debugCounter = 0
	debugCounter += 1
	'''
