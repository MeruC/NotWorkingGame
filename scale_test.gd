extends Button

export (float) var scale

func _on_pressed():
	SignalManager.emit_signal("ui_scale_changed", scale)
