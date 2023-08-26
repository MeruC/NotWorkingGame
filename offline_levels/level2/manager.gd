extends Node2D

export(PackedScene) var letter_scene
export(PackedScene) var blank_scene
var json_file = "res://offline_levels/json/level2_questions.json"
var json_data = ""
var answer
var score = 0
var i

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
# warning-ignore:unused_variable
	var id = json_data[i]["id"]
	var scrambled = json_data[i]["scrambled"]
	var clue = json_data[i]["clue"]
	answer = json_data[i]["answer"]
	$"../clue".text = clue
	
	var x = 0
	for child in $"../letter_container".get_children():
		if child is Button:
			child.text = scrambled[x]
			x += 1
			
	return json_data
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_clear_pressed():
	for child in $"../blank_container".get_children():
		child.text = "_"
	for child in $"../letter_container".get_children():
		child.disabled = false
	pass # Replace with function body.


func _on_submit_pressed():
	i += 1
	var user_answer = ""
	for child in $"../blank_container".get_children():
		user_answer = user_answer + child.text
	if user_answer == answer:
		score += 1
		$"../score".text = str(score)
		
	for child in $"../blank_container".get_children():
		child.queue_free()
	for child in $"../letter_container".get_children():
		child.queue_free()
	$"../clue".text = ""
	
	while (i < 5):
		var scrambled = json_data[i]["scrambled"]
		var clue = json_data[i]["clue"]
		answer = json_data[i]["answer"]
		print(answer)
		$"../clue".text = clue
		var x = 0
		for Char in scrambled:
			var new_letter = letter_scene.instance()
			var new_blank = blank_scene.instance()
			if (new_blank != null):
				$"../blank_container".add_child(new_blank)
				new_blank.text = "_"
				$"../letter_container".add_child(new_letter)
				new_letter.text = scrambled[x]
				x += 1
		return i
	
