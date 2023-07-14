class_name Scale_Control extends Control

var scale : float
var current_size

func _ready():
	SignalManager.connect( "ui_scale_changed", self, "_on_ui_scale_changed" )
	connect( "resized", self, "_on_resized" )
	set_scale( SettingsManager.scale )
	current_size = get_viewport_rect().size

func set_scale( value ):
	scale = value
	rect_scale = Vector2( scale, scale )

func _on_ui_scale_changed( value ):
	set_scale( value )

func _on_resized():
	var new_size = get_viewport_rect().size
	rect_pivot_offset = rect_pivot_offset / current_size * new_size
	current_size = new_size
