extends Node2D

export (PackedScene) var choice_scene
var score = 0
var json_file = "res://offline_levels/json/level3_questions.json"
var json_data = ""
var i
var answer


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
	var incorrect = json_data[i]["incorrect"]
	answer = json_data[i]["answer"]
	$clue.text = clue
	
	var random = randi() % 2
	if random == 0:
		$choices/choices_container/choice1/image_holder.content = answer
		$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
		$choices/choices_container/choice2/image_holder.content = incorrect
		$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
	else:
		$choices/choices_container/choice2/image_holder.content = answer
		$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
		$choices/choices_container/choice1/image_holder.content = incorrect
		$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
	return json_data
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_choice1_pressed():
	i += 1
	var choice = $choices/choices_container/choice1/image_holder.content
	if choice == answer:
		score += 1
		$score.text = str(score)
	
	while i < 5:
		var clue = json_data[i]["question"]
		var incorrect = json_data[i]["incorrect"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		
		var random = randi() % 2
		if random == 0:
			$choices/choices_container/choice1/image_holder.content = answer
			$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			$choices/choices_container/choice2/image_holder.content = incorrect
			$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		else:
			$choices/choices_container/choice2/image_holder.content = answer
			$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			$choices/choices_container/choice1/image_holder.content = incorrect
			$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		return json_data
	
	$clue.queue_free()
	$choices.queue_free()


func _on_choice2_pressed():
	i += 1
	var choice = $choices/choices_container/choice2/image_holder.content
	if choice == answer:
		score += 1
		$score.text = str(score)
	
	while i < 5:
		var clue = json_data[i]["question"]
		var incorrect = json_data[i]["incorrect"]
		answer = json_data[i]["answer"]
		$clue.text = clue
		
		var random = randi() % 2
		if random == 0:
			$choices/choices_container/choice1/image_holder.content = answer
			$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			$choices/choices_container/choice2/image_holder.content = incorrect
			$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		else:
			$choices/choices_container/choice2/image_holder.content = answer
			$choices/choices_container/choice2/image_holder.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			$choices/choices_container/choice1/image_holder.content = incorrect
			$choices/choices_container/choice1/image_holder.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		return json_data
	
	$clue.queue_free()
	$choices.queue_free()
