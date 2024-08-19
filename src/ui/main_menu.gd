class_name MainMenu extends Control

@onready var btn_start_game = $VBoxContainer/BtnStartGame

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)

func _ready():
	btn_start_game.grab_focus()

func _on_game_started():
	queue_free()
