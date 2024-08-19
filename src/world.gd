extends Node3D

func _enter_tree():
	GlobalSignals.game_quit.connect(_on_game_quit)

func _on_game_quit():
	queue_free()
