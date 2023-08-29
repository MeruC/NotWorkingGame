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
		score += 1
		$score.text = str(score)
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	
	$clue.queue_free()
	$button_container.queue_free()
	pass # Replace with function body.


func _on_man_button_pressed():
	if $button_container/man_button.text == answer:
		score += 1
		$score.text = str(score)
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	
	$clue.queue_free()
	$button_container.queue_free()
	pass # Replace with function body.


func _on_wan_button_pressed():
	if $button_container/wan_button.text == answer:
		score += 1
		$score.text = str(score)
	
	while i < 4:
		i += 1
		var clue = json_data[i]["question"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		return answer
	
	$clue.queue_free()
	$button_container.queue_free()
	pass # Replace with function body.
