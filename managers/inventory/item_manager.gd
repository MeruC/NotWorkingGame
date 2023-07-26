extends Node

const ITEM_PATH = "res://global/items/data/items.json"
const AFFIXES_PATH = "res://global/items/data/affixes.json"
const RARE_NAMES_PATH = "res://global/items/data/rare_names.json"

var items = {}
var rare_names = {}
var affix_groups = {}

var equipment_names = {
	Game_Enums.EQUIPMENT_TYPE.HEAD: "Head",
	Game_Enums.EQUIPMENT_TYPE.CHEST: "Armor",
	Game_Enums.EQUIPMENT_TYPE.OFFHAND: "Offhand",
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND: "Weapon"
}

var type_names = {
	Game_Enums.ITEM_TYPE.CONSUMABLE: "Consumable",
	Game_Enums.ITEM_TYPE.CURRENCY: "Currency",
	Game_Enums.ITEM_TYPE.MATERIAL: "Material",
}

onready var placeholders = {
	Game_Enums.EQUIPMENT_TYPE.HEAD : preload("res://global/inventory/sprites/placeholder_head.png"),
	Game_Enums.EQUIPMENT_TYPE.CHEST : preload("res://global/inventory/sprites/placeholder_chest.png"),
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND : preload("res://global/inventory/sprites/placeholder_main_hand.png"),
	Game_Enums.EQUIPMENT_TYPE.OFFHAND : preload("res://global/inventory/sprites/placeholder_offhand.png"),
}

var usable = {
	"healing": preload("res://global/items/usable/item_healing.gd"),
	"upgrade": preload("res://global/items/usable/item_upgrade.gd"),
}

func _init():
	randomize()

func _ready():
	var file = File.new()
	
	# items
	file.open( ITEM_PATH, File.READ )
	items = parse_json( file.get_as_text() )
	file.close()
	
	# names
	file.open( RARE_NAMES_PATH, File.READ )
	rare_names = parse_json(file.get_as_text())
	file.close()
	
	# affixes group
	file.open( AFFIXES_PATH, File.READ )
	var data = parse_json( file.get_as_text() )
	for id in data:
		affix_groups[ id ] = Affix_Group.new( id, data[ id ] )
	file.close()


func get_item( id : String ):
	return Item.new( id, items[ id ] )

func get_placeholder( id ):
	return placeholders[ id ]


# Get random equipable item
func rng_generate_rarity( ilvl ) -> Item:
	var valid_items_key = []
	for i in items:
		if items[ i ].has( "type" ) and ilvl >= items[ i ].level and Game_Enums.ITEM_TYPE[ items[ i ].type ] == Game_Enums.ITEM_TYPE.EQUIPMENT:
			valid_items_key.append( i )
	var item = get_item( valid_items_key[ randi() % valid_items_key.size() ] )
	return generate_random_rarity( item, ilvl )

func generate_random_rarity( item, ilvl ):
	item.components.base_stats.scale = randf()
	
	# Get random rarity
	var rarity = Game_Enums.RARITY.NORMAL
	var rng = randf()
	if rng >= 0 and item.unique_data: # 1%
		rarity = Game_Enums.RARITY.UNIQUE
	elif rng >= 0.9: # 9%
		rarity = Game_Enums.RARITY.RARE
	elif rng >= 0.6: # 30%
		rarity = Game_Enums.RARITY.MAGIC
	
	generate_rarity( item, ilvl, rarity )
	return item


func generate_rarity( item, ilvl, rarity ) -> Item:
	item.rarity = rarity
	var number_of_affixes = 0
	
	if rarity == Game_Enums.RARITY.UNIQUE:
		item.rarity = Game_Enums.RARITY.UNIQUE
		roll_unique( item )
		return item
	elif rarity == Game_Enums.RARITY.RARE:
		item.rarity = Game_Enums.RARITY.RARE
		number_of_affixes = ( randi() % 3 ) + 3
		set_rare_name( item )
	elif rarity == Game_Enums.RARITY.MAGIC:
		item.rarity = Game_Enums.RARITY.MAGIC
		number_of_affixes = ( randi() % 2 ) + 1
	else:
		return item
	
	# Set the affixes
	var random_affix_group = get_random_affix_group( number_of_affixes, item.equipment_type, ilvl )
	var item_affix_list_data = []
	
	for affix_group in random_affix_group:
		var data = {
			"affix_group": affix_group.id,
			"affix": affix_group.get_random_affix( ilvl ),
			"scale": randf()
		}
		item_affix_list_data.append( data )
	
	item.components[ "affix_list" ] = Item_Affix_List.new( item_affix_list_data, item.rarity )
	return item


func get_random_affix_group( affix_amount, item_type, ilvl ) -> Array:
	var valid_prefixes : Array = get_valid_affixes_group( Game_Enums.AFFIX_TYPE.PREFIX, item_type, ilvl )
	var valid_suffixes : Array = get_valid_affixes_group( Game_Enums.AFFIX_TYPE.SUFFIX, item_type, ilvl )
	
	valid_prefixes.shuffle()
	valid_suffixes.shuffle()
	
	var prefix_amount = int( floor( affix_amount / 2.0 ) )
	var suffix_amount = prefix_amount
	
	if affix_amount % 2 == 1:
		if randi() % 2 == 1:
			prefix_amount += 1
		else:
			suffix_amount += 1
	
	valid_prefixes.resize( prefix_amount )
	valid_suffixes.resize( suffix_amount )
	
	var valid_affixes = []
	valid_affixes.append_array( valid_prefixes )
	valid_affixes.append_array( valid_suffixes )
	return valid_affixes


func get_valid_affixes_group( affix_type, item_type, ilvl ):
	var valid_affixes : Array = []
	
	for id in affix_groups:
		if affix_groups[ id ].type == affix_type and ilvl >= affix_groups[ id ].affixes.values()[ 0 ].min_level and affix_groups[ id ].apply_to.has( item_type ):
			valid_affixes.append( affix_groups[ id ] )
	return valid_affixes


func set_rare_name( item ):
	var type = Game_Enums.EQUIPMENT_TYPE.keys()[ item.equipment_type ]
	var name_prefix_type = rare_names.prefix[ type ]
	var name_prefix = name_prefix_type[ randi() % name_prefix_type.size() ]
	var name_suffix_type = rare_names.suffix[ type ]
	var name_suffix = name_suffix_type[ randi() % name_suffix_type.size() ]
	item.item_name = name_prefix + " " + name_suffix


func roll_unique( item ):
	var scales = []
	for s in item.unique_data.stats:
		scales.append( randf() )
	
	item.item_name = item.unique_data.name
	item.components[ "unique_stats" ] = Item_Unique_Stats.new( item.unique_data.stats, scales )
	if item.unique_data.has( "usable" ):
		set_usable( item, item.unique_data )

func get_usable( data_usable, item ):
	return usable[ data_usable.type ].new( data_usable.data, item )

func set_usable( item, data ):
	item.components[ "usable" ] = get_usable( data.usable, item )
	item.add_child( item.components.usable )

func get_type_name( item ):
	if item.type == Game_Enums.ITEM_TYPE.EQUIPMENT:
		return equipment_names[ item.equipment_type ]
	else:
		return type_names[ item.type ]




