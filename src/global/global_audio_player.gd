extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicManager.loaded.connect(_on_music_manager_loaded)

func _on_music_manager_loaded() -> void:
	MusicManager.play("Music", "MainTheme", 2.5, true)
	

func _on_world_loaded(world_name: String) -> void:
	pass
	if world_name == "World1":
		MusicManager.enable_stem("Main")
	elif world_name == "World2":
		MusicManager.play("Music", "Abyss", 8.0, true)
