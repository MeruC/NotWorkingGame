extends CanvasLayer

var default_character = load("res://user_profile/avatar_boy_picture/default_character.png")
var orange_shirt = load("res://user_profile/avatar_boy_picture/orange_shirt.png")
var formal_attire = load("res://user_profile/avatar_boy_picture/character_formal.png")
var blue_shirt = load("res://user_profile/avatar_boy_picture/blue_shirt.png")
var cict_shirt = load("res://user_profile/avatar_boy_picture/cict_shirt.png")
var user_profile = "res://user_profile/user_profile.tscn"
var selectedAvatar = "res://user_profile/avatar_boy_picture/default_character.png"
var click = 0


var change_avatar : Sprite
var current_avatar : Sprite
var avatar : Sprite


func _ready():
		change_avatar = $avatar_selection
		current_avatar = $current_avatar
		avatar = $"../user_profile/name_background/avatar"
		change_avatar.texture = default_character
		current_avatar.texture = default_character

func _on_right_pressed():
		click += 1
		if click > 4:
			click = 4
		elif click == 1:
			change_avatar.texture = formal_attire
			$avatar_name.text = "Formal Attire"
		elif click == 2:
			change_avatar.texture = cict_shirt
			$avatar_name.text = "CICT Firefox Shirt"
		elif click == 3:
			change_avatar.texture = blue_shirt
			$avatar_name.text = "Blue T-Shirt"
		elif click == 4:
			change_avatar.texture = orange_shirt
			$avatar_name.text = "Stripe T-Shirt"
		else:
			change_avatar.texture = default_character
			$avatar_name.text = "Default Character"


func _on_left_pressed():
		click -= 1
		if click == 1:
			change_avatar.texture = formal_attire
			$avatar_name.text = "Formal Attire"
		elif click == 2:
			change_avatar.texture = cict_shirt
			$avatar_name.text = "CICT Firefox Shirt"
		elif click == 3:
			change_avatar.texture = blue_shirt
			$avatar_name.text = "Blue T-Shirt"
		elif click == 4:
			change_avatar.texture = orange_shirt
			$avatar_name.text = "Stripe T-Shirt"
		else:
			change_avatar.texture = default_character
			$avatar_name.text = "Default Character"


func _on_select_btn_pressed():
	# Get the file path of the currently displayed texture
	var currentTexturePath = current_avatar.texture.get_path()
	
	current_avatar.texture = change_avatar.texture
	avatar.texture = current_avatar.texture
	currentTexturePath = current_avatar.texture.get_path()
	
	
	if currentTexturePath == formal_attire.get_path():
		$c_avatar_name.text = "Formal Attire"
	elif currentTexturePath == cict_shirt.get_path():
		$c_avatar_name.text = "CICT Firefox Shirt"
	elif currentTexturePath == blue_shirt.get_path():
		$c_avatar_name.text = "Blue T-Shirt"
	elif currentTexturePath == orange_shirt.get_path():
		$c_avatar_name.text = "Stripe T-Shirt"
	else:
		$c_avatar_name.text = "Default Character"


func _on_back_btn2_pressed():
	$".".visible = false
	$"../user_profile".visible = true
