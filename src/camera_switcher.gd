extends Node3D

var cameras = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		cameras.append(child)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _switch_camera(name:String):
	for cam in cameras:
		cam.current = false
	find_child(name).current = true
	pass
