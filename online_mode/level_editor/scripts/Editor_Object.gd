extends Spatial

export( NodePath ) onready var level = get_node(level) as Spatial
export( NodePath ) onready var preview_item = get_node(preview_item) as StaticBody
export( NodePath ) onready var delete_item = get_node(delete_item) as StaticBody

var current_item 
var cursor_pos := Vector3.ZERO
var current_object

var placeOn = "none"
var height = 0

var object_point

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../level/floor".owner = level
	$"../level/environment".owner = level
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level = get_node("/root/main/level")
	cursor_pos = Vector3(ScrenPointToRay())
	cursor_pos.y = height
	
	#This Snaps the Objects Position to a grid
	cursor_pos.x = stepify(cursor_pos.x, 2)
	cursor_pos.z = stepify(cursor_pos.z, 2)
	
	var object_pos = cursor_pos
	
	#DEBUG, POSITION CHECK
	#print(cursor_pos)
	
	object_point = WhatObject()
	
	if(object_point.has("position")):
		if(Global.edit_mode and Global.can_place):
			for i in placeOn:
				if (i in object_point.collider.name):
					preview_item.set_visible(true)
					delete_item.set_visible(false)
					preview_item.global_translation = cursor_pos
					break
				else:
					preview_item.set_visible(false)
					delete_item.set_visible(true)
					cursor_pos.y = 4
					delete_item.global_translation = cursor_pos	
		if !Global.edit_mode:
			preview_item.set_visible(false)
			delete_item.set_visible(false)
			
		if (Input.is_action_just_pressed("mb_left")):
			print(object_point.collider.name)
			pass
			
		if (Global.edit_mode and Input.is_action_just_pressed("rotate") and "object" in object_point.collider.name):
			current_object = level.get_node(object_point.collider.name)
			current_object.rotate(Vector3(0,1,0),-(PI/2))
			pass
			
		if (Global.edit_mode and Input.is_action_just_pressed("mb_right") and "object" in object_point.collider.name):
			current_object = level.get_node(object_point.collider.name)
			current_object.queue_free()
			pass
			
		#Checks for Input
		if(Global.edit_mode and Global.can_place and Input.is_action_just_pressed("mb_left") and current_item != null):
			var new_item = current_item.instance() 
			if (new_item != null):
				for i in placeOn:
					if (i in object_point.collider.name):
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
