extends TextureProgress

export( NodePath ) onready var lbl = get_node( lbl ) as Label

func set_data( usable ):
	usable.connect( "cooldown_tick", self, "_on_cooldown_tick" )
	max_value = usable.cooldown

func _on_cooldown_tick( remaining ):
	value = remaining
	lbl.text = "%0.2f" % remaining
	
	if remaining <= 0:
		queue_free()
