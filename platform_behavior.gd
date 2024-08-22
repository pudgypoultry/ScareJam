extends StaticBody3D

var message = "Hello World!"
var timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += 1
	if timer % 10 == 0:
		print(timer)
	if timer > 1000:
		print(message)
		timer = 0
