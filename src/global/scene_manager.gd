class_name SceneManager extends Node

const SPLASH_SCREEN : PackedScene = preload("res://assets/ui/splash_screen.tscn")
const MAIN_MENU_SCENE : PackedScene = preload("res://assets/ui/main_menu.tscn")
const WORLD1_SCENE : PackedScene = preload("res://assets/levels/world1.tscn")
const WORLD2_SCENE : PackedScene = preload("res://assets/levels/world2.tscn")

const PAUSE_MENU_SCENE : PackedScene = preload("res://assets/ui/pause_menu.tscn")

@onready var canvas_layer = $CanvasLayer

var current_scene

signal world_loaded(world_name:String)

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)
	GlobalSignals.world_changed.connect(_on_world_changed)

func _ready():
	await load_scene(SPLASH_SCREEN, canvas_layer)
	GlobalSignals.splash_skip.connect(_on_splash_skip)

func _on_splash_skip():
	load_scene(MAIN_MENU_SCENE, canvas_layer)

func _on_game_started():
	load_scene(PAUSE_MENU_SCENE, canvas_layer)
	await load_scene(WORLD1_SCENE, get_node("WorldRoot"))
	world_loaded.emit("World1")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	GlobalSignals.game_quit.connect(_on_game_quit)

func _on_game_quit():
	GlobalSignals.game_quit.disconnect(_on_game_quit)
	load_scene(MAIN_MENU_SCENE, canvas_layer)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_world_changed(world):
	current_scene.queue_free()
	
	if world == "World2":
		load_scene.call_deferred(WORLD2_SCENE, get_node("WorldRoot"))
		world_loaded.emit(world)


func load_scene(scene:PackedScene, parent:Node):
	
	current_scene = scene.instantiate()
	parent.add_child(current_scene)
