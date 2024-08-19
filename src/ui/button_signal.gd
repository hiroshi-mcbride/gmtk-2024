extends BaseButton

@export var on_click : GlobalSignals.Type

func _pressed():
	GlobalSignals.signals[on_click].emit()
