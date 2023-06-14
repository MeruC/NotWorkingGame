extends Spatial

var can_place = true
onready var level = get_node("/root/main/level")
onready var preview_item = get_node("/root/main/preview")
onready var delete_item = get_node("/root/main/delete")
onready var play = get_node("/root/main/play")

var do_save = false

var current_item 
var cursor_pos := Vector3.ZERO
var delete_object

var object_point

export(PackedScene) var preview

var timer = Timer.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	$"../level/floor".owner = level
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cursor_pos = Vector3(ScrenPointToRay())
	cursor_pos.y = 0
	
	#This Snaps the Objects Position to a grid
	cursor_pos.x = stepify(cursor_pos.x, 2)
	cursor_pos.z = stepify(cursor_pos.z, 2)
	#cursor_pos.y = stepify(cursor_pos.y, 2)
	
	#DEBUG, POSITION CHECK
	#print(cursor_pos)
	
	object_point = WhatObject()
	
	#if (preview_level.get_child(0) != object_point.collider):
	#	for n in preview_level.get_children():
	#		preview_level.remove_child(n)
	#		n.queue_free()
	
	if(Global.edit_mode and can_place and object_point.collider.name == "floor"):
		#var preview_item = preview.instance()
		#preview_level.add_child(preview_item)
		#preview_item.global_translation = cursor_pos
		preview_item.set_visible(true)
		delete_item.set_visible(false)
		#print(cursor_pos)
		preview_item.global_translation = cursor_pos
	elif(play.edit_mode and can_place or "object" in object_point.collider.name):
		preview_item.set_visible(false)
		delete_item.set_visible(true)
		cursor_pos.y = 2
		delete_item.global_translation = cursor_pos
	else:
		preview_item.set_visible(false)
		delete_item.set_visible(false)
		
	if (Input.is_action_just_pressed("mb_left")):
		print(object_point.collider.name)
		pass
		
	if (Input.is_action_just_pressed("mb_right") and "object" in object_point.collider.name):
		delete_object = level.get_node(object_point.collider.name)
		print(delete_object)
		delete_object.queue_free()
		pass
		
	#Checks for Input
	if(can_place and Input.is_action_just_pressed("mb_left") and current_item != null and object_point.collider.name == "floor"):
		#	for n in preview_level.get_children():
		#		preview_level.remove_child(n)
		#		n.queue_free()
		var new_item = current_item.instance() 
		if (new_item != null):
			level.add_child(new_item)
			new_item.owner = level
			new_item.global_translation = cursor_pos
	pass
	

#Fires a ray to check for cursor 3D location
func ScrenPointToRay():
	var spaceState = get_world().direct_space_state
	
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(rayOrigin, rayEnd)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()
	
func WhatObject():
	var spaceState = get_world().direct_space_state
	
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(rayOrigin, rayEnd)
	return rayArray
