extends Node

const ITEM_PATH = "res://global/items/data/items.json"
var items = {}

onready var placeholders = {
	Game_Enums.EQUIPMENT_TYPE.HEAD : preload("res://global/inventory/sprites/placeholder_head.png"),
	Game_Enums.EQUIPMENT_TYPE.CHEST : preload("res://global/inventory/sprites/placeholder_chest.png"),
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND : preload("res://global/inventory/sprites/placeholder_main_hand.png"),
	Game_Enums.EQUIPMENT_TYPE.OFFHAND : preload("res://global/inventory/sprites/placeholder_offhand.png"),
}

func _ready():
	var file = File.new()
	file.open( ITEM_PATH, File.READ )
	items = parse_json( file.get_as_text() )
	file.close()

func get_item( id : String ):
	return Item.new( id, items[ id ] )

func get_placeholder( id ):
	return placeholders[ id ]
