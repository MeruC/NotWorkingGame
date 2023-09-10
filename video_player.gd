extends VideoPlayer
var isPlaying = false

signal cancel
signal finish

func _on_start_button_pressed():
	if isPlaying:
		stop()  
	$start_button.visible = false
	$cancel_button.visible = true
	play()
	isPlaying = true


func _on_cancel_button_pressed():
	$start_button.visible = true
	$cancel_button.visible = false
	stop()
	isPlaying = false
	emit_signal("cancel")
	
func _on_video_player_finished():
	isPlaying = false
	emit_signal("finish")
