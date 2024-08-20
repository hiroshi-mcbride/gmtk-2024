extends Control

@export var timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timeout)
	pass # Replace with function body.


func _on_timeout() -> void:
	GlobalSignals.splash_skip.emit()
	queue_free()
