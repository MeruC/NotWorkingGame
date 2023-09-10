extends Control

# This script for directing users into another scene

var level_selection = "res://offline_levels/level_selection/level_selection.tscn"
var level_create = "res://level_create_Menu/level_create.tscn"

func _ready():
	pass # Replace with function body.



func _on_offline_button_pressed():
	get_tree().change_scene(level_selection)


func _on_online_button_pressed():
	get_tree().change_scene(level_create)
