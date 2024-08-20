extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.loaded.connect(_on_music_manager_loaded)
	GlobalSignals.game_quit.connect(_on_game_quit)
	

func _on_music_manager_loaded() -> void:
	MusicManager.play("Music", "MainTheme", 2.5, false)
	MusicManager.disable_stem("Main", 0.0)
	
func _on_game_quit() -> void:
	if MusicManager.is_playing("Music", "Abyss"):
		MusicManager.play("Music", "MainTheme", 2.5, false)
	else:
		MusicManager.disable_stem("Main")

func _on_world_loaded(world_name: String) -> void:
	pass
	if world_name == "World1":
		MusicManager.enable_stem("Main")
	elif world_name == "World2":
		MusicManager.disable_stem("Main")
		MusicManager.play("Music", "Abyss", 8.0, false)
