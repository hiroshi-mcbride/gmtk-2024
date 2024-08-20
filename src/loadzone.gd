extends Area3D

@export var level : int
var root : Node3D
var scene : PackedScene

func _ready():
	root = get_tree().root.get_node("GameRoot")
	print(root)
	scene = load(str("res://assets/levels/world", level, ".tscn"))

func _on_body_entered(body):
	root.load_scene(scene, root)
