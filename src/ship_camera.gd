class_name ShipCamera extends Camera3D

@export var follow_subject : Node3D
@export var follow_distance : float
@export var lookahead_distance : float
@export var deadzone : Vector2
@export var offset : Vector3
@export_range(0.001, 1.0) var follow_damping : float
@export_range(0.001, 8.0) var lookat_damping : float

@onready var center := Vector2(get_viewport().size*0.5)

var global_lookat : Vector3
var last_lookat
var subject_position

func _process(delta) -> void:
	if follow_subject == null: 
		return
	
	global_position = global_position.slerp(get_follow_position(), follow_damping)
	#look_at(follow_subject.global_position - follow_subject.basis.z * lookahead_distance)
	
	#rotation.z = lerp_angle(rotation.z, follow_subject.rotation.z, lookat_damping)
	
	#var frame_out_bounds := get_framed_side_offset()
	#var diff := get_position_offset_distance() - global_position
	#var current_distance := diff.length_squared()
	#if diff.z != 0:
		#global_position = get_position_offset_distance()
	#
	#last_lookat = global_lookat
	#global_lookat = get_target_lookat_offset()
	#look_at(lerp(last_lookat, global_lookat, delta / lookat_damping))


func get_follow_position() -> Vector3:
	return follow_subject.global_position + follow_subject.basis.z * follow_distance

#
#func set_target(target:Node3D) -> void:
	#follow_subject = target
#
#
#func snap_to_target() -> void:
	#global_position = get_position_offset_distance()
	#look_at(get_target_lookat_offset())
#
#
#func get_position_offset_distance() -> Vector3:
	#return get_target_position_offset() + follow_subject.basis.z * follow_distance
#
#
#func get_target_position_offset() -> Vector3:
	#return follow_subject.global_position + offset
#
#
#func get_target_lookat_offset() -> Vector3:
	#return get_target_position_offset() - follow_subject.basis.z * lookahead_distance
#
#
#func get_framed_side_offset() -> Vector2:
	#var frame_out_bounds := Vector2.ZERO
	#var screen_position := unproject_position(get_target_position_offset())
#
	#if screen_position.x < center.x - deadzone.x / 2:
		## Is outside left edge
		#frame_out_bounds.x = -1
#
	#if screen_position.y < center.y - deadzone.y / 2:
		## Is outside top edge
		#frame_out_bounds.y = 1
#
	#if screen_position.x > center.x + deadzone.x / 2:
		## Is outside right edge
		#frame_out_bounds.x = 1
#
	#if screen_position.y > center.y + deadzone.y / 2:
		## Is outside bottom edge
		#frame_out_bounds.y = -1
#
	#return frame_out_bounds
