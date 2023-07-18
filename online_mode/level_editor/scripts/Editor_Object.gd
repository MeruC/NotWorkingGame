extends Spatial

export( NodePath ) onready var level = get_node(level) as Spatial
export( NodePath ) onready var preview_parent = get_node(preview_parent) as Spatial
export( NodePath ) onready var place_preview = get_node(place_preview) as StaticBody
export( NodePath ) onready var remove_preview = get_node(remove_preview) as StaticBody
export( NodePath ) onready var rotate_preview = get_node(rotate_preview) as StaticBody
export( NodePath ) onready var no_sign = get_node(no_sign) as StaticBody

var current_item 
var cursor_pos := Vector3.ZERO
var object_pos
var current_object

var placeOn = "none"
var height = 0

var object_point

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../level/floor".owner = level
	$"../level/environment".owner = level
	pass
	
func _input(event):
	if event is InputEventScreenTouch:
		match(Global.editor_mode):
			"place":
				placeObject()
			"rotate":
				rotateObject()
			"remove":
				removeObject()
	if event is InputEventMouseButton and event.is_pressed():
		match(Global.editor_mode):
			"place":
				placeObject()
			"rotate":
				rotateObject()
			"remove":
				removeObject()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	level = get_node("/root/main/level")
	cursor_pos = Vector3(ScrenPointToRay())
	cursor_pos.y = 0
	
	#This Snaps the Objects Position to a grid
	cursor_pos.x = stepify(cursor_pos.x, 2)
	cursor_pos.z = stepify(cursor_pos.z, 2)
	
	object_pos = cursor_pos

	object_point = WhatObject()
	
	preview_parent.set_visible(false)
	no_sign.set_visible(true)
	
	#Preview
	match(Global.editor_mode):
		"place":
			previewCursor()
			place_preview.set_visible(true)
			rotate_preview.set_visible(false)
			remove_preview.set_visible(false)
			for i in placeOn:
				if (i in object_point.collider.name):
					preview_parent.set_visible(true)
					no_sign.set_visible(false)
					break
		"rotate":
			previewCursor()
			place_preview.set_visible(false)
			rotate_preview.set_visible(true)
			remove_preview.set_visible(false)
			if ("object" in object_point.collider.name):
				preview_parent.set_visible(true)
				no_sign.set_visible(false)
		"remove":
			previewCursor()
			place_preview.set_visible(false)
			rotate_preview.set_visible(false)
			remove_preview.set_visible(true)
			if ("object" in object_point.collider.name):
				preview_parent.set_visible(true)
				no_sign.set_visible(false)
	
	if(object_point.has("position")):	
		if (Input.is_action_just_pressed("mb_left")):
			print(object_point)
			pass
		pass
	
func previewCursor():
	if(object_point.has("position")):
		preview_parent.global_translation = cursor_pos
		preview_parent.global_translation.y = 10.0
		no_sign.global_translation = cursor_pos
		no_sign.global_translation.y = 10.0
				
func placeObject():
	cursor_pos.y = 0
	if !("floor" in object_point.collider.name): cursor_pos.y = height
	if (Global.can_place and current_item != null):
		var new_item = current_item.instance() 
		if (new_item != null):
			for i in placeOn:
				if (i in object_point.collider.name):
					level.add_child(new_item)
					new_item.owner = level
					new_item.global_translation = cursor_pos
	
func rotateObject():
	if ("object" in object_point.collider.name):
		current_object = level.get_node(object_point.collider.name)
		current_object.rotate(Vector3(0,1,0),-(PI/2))
	
func removeObject():
	if ("object" in object_point.collider.name):
		current_object = level.get_node(object_point.collider.name)
		current_object.queue_free()
	
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
