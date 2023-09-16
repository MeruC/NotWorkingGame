class_name Cable extends Item_Usable

var cable_type

func _init( data, parent_item ).( data, parent_item ):
	SignalManager.connect( "player_life_changed", self, "_on_player_life_changed")
	on_use_text = "Heal %s life points."
	condition = "Need healing."
	can_always_use = true

func set_data( data ):
	cable_type = data.cable_type
	.set_data( data )

func get_use_text():
	return "Cable Type: " + cable_type.capitalize() 

func _on_player_life_changed( life, max_life ):
	pass

func execute():
	#SignalManager.emit_signal( "heal_player", healing_amount )
	print( "Cable Type: " + cable_type.capitalize() )
