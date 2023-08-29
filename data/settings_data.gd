class_name Settings_Data extends Resource

export( bool ) var fullscreen = false
export( float ) var scale = 2

func set_data( data ):
	fullscreen = data.fullscreen
	scale = data.scale
	#print(fullscreen, scale, "success")
	emit_changed()

func get_data():
	return {
		"fullscreen": fullscreen,
		"scale": scale
	}
