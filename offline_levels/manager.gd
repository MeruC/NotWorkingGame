extends Node2D

export(PackedScene) var this_scene
var score = 0

func _ready():
	pass

func spawn_new():
	#level.add_child(new_item)
	var new_item = this_scene.instance() 
	if (new_item != null):
		$"..".add_child(new_item)
		new_item.owner = $".."
		new_item.position = Vector2(430, 230)
		new_item.type = "info"
		$"../Label".text = new_item.type
