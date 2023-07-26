extends Chest

export( int ) var number_of_items

func set_items():
	for nb in number_of_items:
		var item = ItemManager.get_item( items[ randi() % items.size() ] )
		
		if item.equipment_type != Game_Enums.EQUIPMENT_TYPE.NONE:
			ItemManager.generate_random_rarity( item, 100 )
		
		inventory.add_item( item )
