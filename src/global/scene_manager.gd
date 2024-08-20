class_name SceneManager extends Node

const MAIN_MENU_SCENE : PackedScene = preload("res://assets/ui/main_menu.tscn")
const WORLD_SCENE : PackedScene = preload("res://assets/levels/world1.tscn")
const PAUSE_MENU_SCENE : PackedScene = preload("res://assets/ui/pause_menu.tscn")

@onready var canvas_layer = $CanvasLayer

var current_scene

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)

func _ready():
	load_scene(MAIN_MENU_SCENE, canvas_layer)

func _on_game_started():
	load_scene(WORLD_SCENE, self)
	load_scene(PAUSE_MENU_SCENE, canvas_layer)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	%MenuAmbience.stop()
	
	GlobalSignals.game_quit.connect(_on_game_quit)

func _on_game_quit():
	GlobalSignals.game_quit.disconnect(_on_game_quit)
	load_scene(MAIN_MENU_SCENE, canvas_layer)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func load_scene(scene:PackedScene, parent:Node):
	var loaded_scene = scene.instantiate()
	parent.add_child(loaded_scene)
