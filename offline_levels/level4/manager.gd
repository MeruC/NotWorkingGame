extends Node2D

var score = 0
var json_file = "res://offline_levels/json/level4_questions.json"
var json_data = ""
var i
var answer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.open(json_file, File.READ) == OK:
		var json_content = file.get_as_text()
		file.close()
		var json_result = JSON.parse(json_content)
		if json_result.error == OK:
			json_data = json_result.result
		else:
			print("JSON parsing error:", json_result.error_string)
	else:
		print("Failed to open JSON file.")
		
	i = 0
	var clue = json_data[i]["question"]
	answer = json_data[i]["answer"]
	$clue.text = clue
	return answer
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_lan_button_pressed():
	if $button_container/lan_button.text == answer:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_correct"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/correct.png")
		score += 1
		$score.text = str(score)
	else:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_wrong"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/incorrect.png")
		
	$popup_layer/popup.visible = true
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	i+=1
	
	$clue.queue_free()
	$button_container.queue_free()
	


func _on_man_button_pressed():
	if $button_container/man_button.text == answer:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_correct"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/correct.png")
		score += 1
		$score.text = str(score)
	else:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_wrong"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/incorrect.png")
		
	$popup_layer/popup.visible = true
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	i+=1
	
	$clue.queue_free()
	$button_container.queue_free()
	


func _on_wan_button_pressed():
	if $button_container/wan_button.text == answer:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_correct"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/correct.png")
		score += 1
		$score.text = str(score)
	else:
		$popup_layer/popup/main_popup/explaination.text = json_data[i]["if_wrong"]
		$popup_layer/popup/main_popup/logo.texture = load("res://offline_mode_Asset/level_4/incorrect.png")
		
	$popup_layer/popup.visible = true
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	i+=1
	
	$clue.queue_free()
	$button_container.queue_free()

func _on_tap_pressed():
	$popup_layer/popup.visible = false
	if i == 5:
		if $score.text == "4" || $score.text == "5":
			$popup_layer/game_over/main_popup/indicator.text = "Level Complete!"
			$popup_layer/game_over/main_popup/GridContainer/next.disabled = false
		else:
			$popup_layer/game_over/main_popup/indicator.text = "Level Failed!"
			$popup_layer/game_over/main_popup/GridContainer/next.disabled = true
	
		$popup_layer/game_over/main_popup/score.text = "Your Score: " + $score.text + " / 5"
		$popup_layer/game_over.visible = true
	pass # Replace with function body.


func _on_retry_pressed():
	var current_scene_path = get_tree().current_scene
	get_tree().change_scene("res://offline_levels/level4/level4.tscn")
	pass # Replace with function body.
