extends CharacterBody3D

var camera_3d: Camera3D
@export var oozle_speed: float
@export_range(-1,1) var oozle_sigmoid_cutoff: float
@onready var ray: RayCast3D = $RayCast3D

var input_vector : Vector2
var relative_input_vector : Vector3

func _ready() -> void:
	var p = get_parent()
	assert(p is Player)
	
	camera_3d = p.camera_3d

func _process(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	var forward = camera_3d.global_basis.z
	var right = camera_3d.global_basis.x
	
	# stop player from oozling backwards (slugs cant do this in real life)
	#var input_vector_y_forward_only = input_vector.y * _sigmoid(input_vector.y)
	#if input_vector_y_forward_only > oozle_sigmoid_cutoff: input_vector_y_forward_only = 0
	
	relative_input_vector = forward * input_vector.y + right * input_vector.x
	relative_input_vector.y = 0.0
	var new_speed = velocity.lerp(relative_input_vector * oozle_speed, 0.9)
	velocity.y += get_gravity().y * delta
	velocity = Vector3(new_speed.x, velocity.y, new_speed.z)
	move_and_slide()
	if is_on_floor():
		global_transform = global_transform.interpolate_with(align_with_y(global_transform, get_floor_normal()), delta * 30.0)
	#print(global_basis.y.cross(get_floor_normal()))
	
	
	#rotation.x = -global_basis.y.cross(get_floor_normal()).x
	
	if input_vector.length_squared() > 0:
		var dir = Vector2(velocity.x, velocity.z)
		var target_angle = -atan2(velocity.z, velocity.x) - deg_to_rad(90)
		rotation.y = lerp_angle(rotation.y, target_angle, delta * 10.0)
	
	
	#print(velocity)
	

func _sigmoid(x:float) -> float:
	return 1 / (1 + pow(2.71828, x))


func get_lookat():
	return $SlugBody/Head

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
