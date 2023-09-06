extends Control

# This script for directing users into another scene

var main_screen = "res://main_screen/main_screen.tscn"
var level1 = "res://offline_levels/level1/level1_discussion/level1_discussion.tscn"
var level2 = "res://offline_levels/level2/level2_discussion/level2_discussion.tscn"
var level3 = "res://offline_levels/level3/level3_discussion/level3_discussion.tscn"
var level4 = "res://offline_levels/level4/level4_discussion/level4_discussion.tscn"
var level5 = "res://offline_levels/level5/level5_discussion/level5_discussion.tscn"

func _ready():
	pass # Replace with function body.

func _on_back_button_pressed():
	get_tree().change_scene(main_screen)


func _on_level1_pressed():
	get_tree().change_scene(level1)


func _on_level2_pressed():
	get_tree().change_scene(level2)


func _on_level3_pressed():
	get_tree().change_scene(level3)


func _on_level4_pressed():
	get_tree().change_scene(level4)


func _on_level5_pressed():
	get_tree().change_scene(level5)
