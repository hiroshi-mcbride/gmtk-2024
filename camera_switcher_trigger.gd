extends Area3D

@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body

func _on_body_entered(body):
	%CameraSwitcher._switch_camera(camera)
