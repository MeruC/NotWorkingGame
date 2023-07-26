class_name Item_Healing extends Item_Usable

var healing_amount

func _init( data, parent_item ).( data, parent_item ):
	SignalManager.connect( "player_life_changed", self, "_on_player_life_changed")
	on_use_text = "Heal %s life points."
	condition = "Need healing."
	can_always_use = true

func set_data( data ):
	healing_amount = data.healing
	.set_data( data )

func get_use_text():
	return on_use_text % healing_amount

func _on_player_life_changed( life, max_life ):
	can_use = life < max_life

func execute():
	SignalManager.emit_signal( "heal_player", healing_amount )
	print( "Healing the player for %s life point!" % healing_amount )
