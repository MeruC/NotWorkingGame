extends Node2D

var edit_avatar = "res://user_profile/change_avatar.tscn"
var main_menu = "res://main_screen/main_screen.tscn"

func _ready():
	$AnimationPlayer.play("background_animation")
	
func _on_edit_avatar_pressed():
	get_tree().change_scene(edit_avatar)


func _on_back_btn_pressed():
	get_tree().change_scene(main_menu)
