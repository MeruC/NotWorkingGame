extends VideoPlayer
var isPlaying = false
func _on_start_button_pressed():
	$start_button.visible = false
	$cancel_button.visible = true
	
	if not isPlaying:
		play()
		isPlaying = true

func _on_cancel_button_pressed():
	$start_button.visible = false
	$cancel_button.visible = false
	$".".visible = false
	stop()
	isPlaying = false
