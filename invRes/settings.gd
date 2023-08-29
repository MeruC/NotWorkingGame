extends ColorRect

export( NodePath ) onready var scale_slider = get_node( scale_slider ) as HSlider
export( NodePath ) onready var fullscreen_check = get_node( fullscreen_check ) as CheckBox
export( NodePath ) onready var lbl_min = get_node( lbl_min ) as Label
export( NodePath ) onready var lbl_max = get_node( lbl_max ) as Label
export( NodePath ) onready var lbl_cur = get_node( lbl_cur ) as Label

export( Resource ) var settings_data

func _ready():
	fullscreen_check.pressed = SettingsManager.fullscreen
	lbl_min.text = "Min: %s" % scale_slider.min_value
	lbl_max.text = "Max: %s" % scale_slider.max_value
	lbl_cur.text = "%s" % scale_slider.value
	settings_data.connect( "changed", self, "_on_data_changed" )
	_on_data_changed()
	
func _on_close_pressed():
	Global.editor_mode = Global.e_mode_history
	hide()


func _on_scale_slider_gui_input( event ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		SettingsManager.scale = scale_slider.value
		lbl_cur.text = "%s" % scale_slider.value

func _on_CheckBox_toggled( button_pressed ):
	SettingsManager.fullscreen = button_pressed
	
func _on_data_changed():
	fullscreen_check.pressed = settings_data.fullscreen
	scale_slider.value = settings_data.scale


func _on_saveBtn_pressed():
	SaveManager.save_game()


func _on_loadBtn_pressed():
	SaveManager.load_game()

