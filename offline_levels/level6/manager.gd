extends Node2D

var wire_textures = [preload("res://offline_mode_Asset/level_6/blue.png"),
						preload("res://offline_mode_Asset/level_6/brown.png"),
						preload("res://offline_mode_Asset/level_6/green.png"),
						preload("res://offline_mode_Asset/level_6/orange.png"),
						preload("res://offline_mode_Asset/level_6/whiteBlue.png"),
						preload("res://offline_mode_Asset/level_6/whiteBrown.png"),
						preload("res://offline_mode_Asset/level_6/whiteGreen.png"),
						preload("res://offline_mode_Asset/level_6/whiteOrange.png")]
var strippedWire_textures = [preload("res://offline_mode_Asset/level_6/stripped_blue.png"),
						preload("res://offline_mode_Asset/level_6/stripped_brown.png"),
						preload("res://offline_mode_Asset/level_6/stripped_green.png"),
						preload("res://offline_mode_Asset/level_6/stripped_orange.png"),
						preload("res://offline_mode_Asset/level_6/stripped_whiteBlue.png"),
						preload("res://offline_mode_Asset/level_6/stripped_whiteBrown.png"),
						preload("res://offline_mode_Asset/level_6/stripped_whiteGreen.png"),
						preload("res://offline_mode_Asset/level_6/stripped_whiteOrange.png")]
						
export (NodePath) onready var wire_container =  get_node(wire_container) as Control
export (NodePath) onready var slot_container =  get_node(slot_container) as Control
export (NodePath) onready var submit_button =  get_node(submit_button) as Button

var level6 = "res://offline_levels/level6/level6.tscn"

func _ready():
	for child in wire_container.get_children():
		var number = rand_range(0, wire_textures.size())
		child.texture = wire_textures[number]
		child.type = "wire"
		child.content = strippedWire_textures[number]
		wire_textures.remove(number)
		strippedWire_textures.remove(number)
		


func _on_reset_pressed():
	get_tree().change_scene(level6)
