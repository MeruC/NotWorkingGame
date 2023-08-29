class_name Player_Data extends Resource

export( Vector3 ) var global_position = Vector3( 0, 0, 0 )
export( Dictionary ) var inventories

var base_stats = {
	Game_Enums.STAT.STRENGTH: 5,
	Game_Enums.STAT.DEXTERITY: 5,
	Game_Enums.STAT.VITALITY: 5,
	Game_Enums.STAT.INTELLIGENCE: 5,
	Game_Enums.STAT.MOVE_SPEED: 150
}

func set_data( data ):
	global_position = data.global_position
	inventories = data.inventories
	emit_changed()

func get_data():
	return {
		"global_position": global_position,
		"inventories": inventories
	}

func get_stat( stat ):
	var stat_total = 0
	
	if base_stats.has( stat ):
		stat_total += base_stats[ stat ]
	
	for inv in InventoryManager.get_inventories_from_group( "equipment" ):
		stat_total += inv.get_stat( stat )
	
	var stat_data = ResourceManager.stat_info[ stat ]
	if stat_data.has( "affected_by" ):
		for main_stat in stat_data.affected_by:
			stat_total += get_stat( Game_Enums.STAT[ main_stat ] ) * stat_data.affected_by[ main_stat ]
	
	return int( round( stat_total ) )
