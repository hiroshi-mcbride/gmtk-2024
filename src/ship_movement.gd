class_name ShipMovement extends RigidBody3D


@onready var ship_model := get_node("ShipModel")

@export var thrust_speed = 10.0 
@export_range(0,2.0) var turn_speed = 1.0
@export_range(0,0.5) var max_angle = 0.29

var torque = 20000

var input_vector := Vector2()
var aim_direction := Vector2()
var acceleration_input = 0.0
var brake_input = 0.0
var current_acceleration = 0.0

var input_x : float
var input_y : float


func _process(_delta) -> void:
	input_x = Input.get_axis("move_left", "move_right")
	input_y = Input.get_axis("move_down", "move_up")
	
	#input_vector = Input.get_vector("move_left", "move_right", "move_down", "move_up")
	acceleration_input = Input.get_action_strength("accelerate")
	brake_input = Input.get_action_strength("brake")
	
	#aim_direction = input_vector * PI * max_angle


func _physics_process(delta) -> void:
	current_acceleration = acceleration_input - brake_input
	current_acceleration = clamp(current_acceleration, -1.0, 1.0)
	#
	#var force = get_force()
	#var col := move_and_collide(force * delta)
	#if col != null:
		#var d = col.get_normal().dot(force.normalized())
		#if d < -0.75 || d > 0.75:
			#apply_central_impulse(-force)
			#current_acceleration *= 0.5
		#else:
			#current_acceleration *= 0.8
		#apply_central_impulse(col.get_normal() * force.length() / 2)


func _integrate_forces(state) -> void:
	var forward_velocity = -basis.z * current_acceleration * thrust_speed
	state.apply_central_force(forward_velocity)
	
	var pitch = input_y * Vector3.RIGHT * turn_speed
	state.apply_torque(pitch)
	var yaw = -input_x * Vector3.UP * turn_speed
	state.apply_torque(yaw)
	#var roll = -input_z * basis.z * turn_speed
	#state.apply_torque(roll)
	
	
	#var target_yaw = -aim_direction.x
	#var yaw = lerp_angle(0, target_yaw, state.step * PI * turn_speed)
	##rotation.y += yaw
	#rotate_y(yaw)
	#rotate_object_local(basis.y, yaw)
	#
	#var target_pitch = -aim_direction.y
	#var pitch = lerp_angle(0, target_pitch, state.step * PI * turn_speed)
	#rotation.x += pitch
	#rotation.x = clampf(rotation.x, -.4999 * PI, .4999 * PI)
	#
	#rotation.z = lerp_angle(rotation.z, 0, 1)
	#var target_roll = -aim_direction.x
	#var roll = lerp_angle(ship_model.rotation.z, target_roll, state.step * PI * turn_speed)
	#ship_model.rotate_z(roll - ship_model.rotation.z)
	#
	## prevent weird movement behavior after collision impulse
	## lucky for me, i don't use linear velocity for movement, so i can just interpolate it to 0
	#var l = linear_velocity.length_squared()
	#if l > 0.1:
		#linear_velocity = linear_velocity.lerp(Vector3.ZERO, state.step * 2)
	#elif l > 0:
		#linear_velocity = Vector3.ZERO


func get_force() -> Vector3:
	return -basis.z * current_acceleration * thrust_speed
