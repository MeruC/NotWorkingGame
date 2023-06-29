extends Control

onready var width = get_node("/root/level_create/w")
onready var depth = get_node("/root/level_create/d")

var cur_w = 10
var cur_d = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_create_pressed():
	Global.w = cur_w
	Global.d = cur_d
	get_tree().change_scene_to(load("res://main.tscn"))
	pass # Replace with function body.


func _on_w_value_changed(value):
	cur_w = value
	pass # Replace with function body.


func _on_d_value_changed(value):
	cur_d = value
	pass # Replace with function body.
