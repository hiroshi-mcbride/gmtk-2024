extends Camera3D

@export var follow_subject : Node3D
@export var follow_distance : float
@export var lookahead_distance : float
@export var deadzone : Vector2
@export var offset : Vector3
@export_range(0.001, 60.0) var follow_damping : float
@export_range(0.001, 60.0) var lookat_damping : float

var lookat

func _ready() -> void:
	lookat = follow_subject.get_lookat()

func _physics_process(delta: float) -> void:
	var yrad = deg_to_rad(global_rotation.y)
	var lookat_yrad = deg_to_rad(lookat.global_rotation.y)
	transform = transform.interpolate_with(transform.looking_at(lookat.global_position), lookat_damping * delta)
	
	global_position = global_position.slerp(get_lookat_follow_position(lookat), follow_damping * delta)

func get_lookat_follow_position(lookat) -> Vector3:
	var lookat_back = lookat.global_position + lookat.global_basis.z * follow_distance
	return lookat_back + offset
