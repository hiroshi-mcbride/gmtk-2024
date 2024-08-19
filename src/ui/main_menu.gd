class_name MainMenu extends Control

@onready var btn_start_game:Button = $VBoxContainer/BtnStartGame
@onready var btn_quit_game:Button = $VBoxContainer/BtnQuitGame
func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)

func _ready():
	InputHelper.device_changed.connect(_on_input_device_changed)
	btn_start_game.grab_focus()

func _on_game_started():
	queue_free()


func _on_input_device_changed(device:String, device_index:int) -> void:
	if device == InputHelper.DEVICE_KEYBOARD:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		btn_start_game.release_focus()
		btn_quit_game.release_focus()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		btn_start_game.grab_focus()
