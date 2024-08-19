class_name PauseMenu extends Control

@onready var overlay = $Overlay
@onready var btn_resume = $Overlay/VBoxContainer/BtnResume

func _enter_tree():
	GlobalSignals.game_resumed.connect(_on_resume)
	GlobalSignals.game_quit.connect(_on_game_quit)

func _ready():
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
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_game_quit():
	get_tree().paused = false
	queue_free()
