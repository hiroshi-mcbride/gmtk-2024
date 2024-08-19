class_name PauseMenu extends Control

@onready var overlay = $Overlay
@onready var btn_resume:Button = $Overlay/VBoxContainer/BtnResume
@onready var btn_main_menu: Button = $Overlay/VBoxContainer/BtnMainMenu
@onready var btn_quit_game: Button = $Overlay/VBoxContainer/BtnQuitGame

var buttons = [btn_resume, btn_main_menu, btn_quit_game]

func _enter_tree():
	GlobalSignals.game_resumed.connect(_on_resume)
	GlobalSignals.game_quit.connect(_on_game_quit)

func _ready():
	InputHelper.device_changed.connect(_on_input_device_changed)
	overlay.visible = false

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		overlay.visible = get_tree().paused
		if overlay.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			btn_resume.grab_focus()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED



func _on_resume():
	get_tree().paused = false
	overlay.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_game_quit():
	get_tree().paused = false
	queue_free()

func _on_input_device_changed(device:String, device_index:int) -> void:
	if !overlay.visible:
		return
	if device == InputHelper.DEVICE_KEYBOARD:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		btn_resume.release_focus()
		btn_main_menu.release_focus()
		btn_quit_game.release_focus()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		btn_resume.grab_focus()
