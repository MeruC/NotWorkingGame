extends VideoPlayer


func _on_start_button_pressed():
	$start_button.visible = false
	$cancel_button.visible = true
	play()


func _on_cancel_button_pressed():
	$start_button.visible = true
	$cancel_button.visible = false
	stop()
