class_name Item_Unique_Stats extends Resource

var stat_scales = []

func _init( data, scales ):
	for i in data.size():
		stat_scales.append( Stat_Scale.new( data[ i ], scales[ i ] ) )

func set_info( item_info ):
	item_info.add_splitter()
	for stat_scale in stat_scales:
		stat_scale.set_info( item_info, Game_Enums.RARITY.UNIQUE )
