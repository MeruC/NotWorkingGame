extends FileDialog

onready var level = get_node("/root/main/level")
onready var ui = get_node("/root/main/UI")
onready var play = get_node("/root/main/UI/editor/modes/play")
onready var main = get_node("/root/main")

func refresh():
	self._draw()
	
func _draw():
	set_current_dir("res://online_mode/level_editor/SavedLevels/")

onready var popup : FileDialog = get_node("/root/main/UI/editor/FileDialog")

func _on_Save_pressed():

	play.set_visible(false)
	ui.set_visible(false)
	Global.can_place = false
	popup.mode = 4
	popup.popup()
	pass # Replace with function body.

func _on_Load_pressed():
	play.set_visible(false)
	ui.set_visible(false)
	Global.can_place = false
	popup.mode = 0
	popup.popup()
	pass # Replace with function body.


func _on_FileDialog_popup_hide():
	Global.can_place = true
	play.set_visible(true)
	ui.set_visible(true)
	pass # Replace with function body.
	

func _on_FileDialog_confirmed():
	if popup.window_title == "Save a File":
		save_level()
	else:
		load_level()
	pass # Replace with function body.

func save_level():
	var toSave : PackedScene = PackedScene.new()
	toSave.pack(level)
	ResourceSaver.save(popup.current_path,toSave)
	
func load_level():
	var toLoad : PackedScene = PackedScene.new()
	toLoad = ResourceLoader.load(popup.current_path)
	var this_level = toLoad.instance()
	main.remove_child(level)
	level.queue_free()
	main.add_child(this_level)
	level = this_level
	
func new_level():
	get_tree().change_scene_to(load("res://level_create_Menu/level_create.tscn"))
	pass

func _on_Save_mouse_entered():
	Global.can_place = false
	

func _on_Save_mouse_exited():
	Global.can_place = true


func _on_Load_mouse_entered():
	Global.can_place = false


func _on_Load_mouse_exited():
	Global.can_place = true


func _on_New_pressed():
	new_level()


func _on_Orphan_pressed():
	 print_stray_nodes()

