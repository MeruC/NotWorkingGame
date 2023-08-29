class_name Game_Data extends Resource

export( Resource ) var settings_data
export( Resource ) var player_data

func set_data( data ):
	settings_data.set_data( data.settings_data )
	player_data.set_data( data.player_data )
	emit_changed()

func get_data():
	return {
		"settings_data": settings_data.get_data(),
		"player_data": player_data.get_data()
	}
