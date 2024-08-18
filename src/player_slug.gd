extends Node3D

@export var camera_3d: Camera3D
@onready var path_3d: Path3D = $SlugBody

var input_vector : Vector2
var relative_input_vector : Vector3

func _process(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var forward = camera_3d.global_basis.z
	var right = camera_3d.global_basis.x
	relative_input_vector = forward * input_vector.y + right * input_vector.x
	relative_input_vector.y = 0.0

func _physics_process(delta: float) -> void:
	var curve = path_3d.curve
	var point0 = curve.get_point_position(0)
	var point1 = curve.get_point_position(1)
	var point2 = curve.get_point_position(2)
	
	curve.set_point_position(0, point0 + relative_input_vector * 5 * delta)
	curve.set_point_position(1, curve.sample_baked(0.5))
	curve.set_point_position(2, curve.sample_baked(1))
	
	#var new_speed = velocity.lerp(relative_input_vector * SPEED, 0.9)
	#velocity = Vector3(new_speed.x, 0.0, new_speed.z)
	#move_and_slide()
