extends Chest

func set_items():
	pass

func interact():
	for s in inventory.slots:
		var old_item = s.put_item( null )
		if old_item: old_item.queue_free()
	
	for nb in inventory.slots.size():
		inventory.add_item( ItemManager.rng_generate_rarity( 100 ) )
	
	SignalManager.emit_signal( "inventory_opened", inventory )
