extends CharacterBody2D

var h_input : float = 0.0
var v_input : float = 0.0

func _physics_process(delta: float) -> void:
	move_and_collide(Input.get_vector("move_left","move_right", "move_up","move_down") * 5.0)
	pass

#func _input(event: InputEvent) -> void:
	#var left = event.get_action_strength("move_left")
	#print("left: " + str(left))
	#var right = event.get_action_strength("move_right")
	#print("right: " + str(right))
	#h_input = right-left
	#print(h_input)
	#var up = event.get_action_strength("move_up")
	#var down = event.get_action_strength("move_down")
	#v_input = down-up
