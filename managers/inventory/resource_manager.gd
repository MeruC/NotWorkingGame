class_name Resource_Manager extends Node

const STAT_PATH = "res://data/json/stats.json"
const RECIPE_PATH = "res://data/json/recipes.json"

var sprites = {
	"chestplate": preload("res://global/items/sprites/chestplate.png"),
	"crystal": preload("res://global/items/sprites/crystal.png"),
	"gold_coin": preload("res://global/items/sprites/gold_coin.png"),
	"helmet": preload("res://global/items/sprites/helmet.png"),
	"iron_sword": preload("res://global/items/sprites/iron_sword.png"),
	"magic_orb": preload("res://global/items/sprites/magic_orb.png"),
	"shield": preload("res://global/items/sprites/shield.png"),
	"stone_brick": preload("res://global/items/sprites/stone_brick.png"),
	"tshirt": preload("res://global/items/sprites/tshirt.png"),
	"wood": preload("res://global/items/sprites/wood.png"),
	"wooden_sword": preload("res://global/items/sprites/wooden_sword.png"),
	"small_healing_potion": preload("res://global/items/sprites/small_red_potion.png"),
	"big_healing_potion": preload("res://global/items/sprites/big_red_potion.png"),
	"rarity_upgrade": preload("res://global/items/sprites/rarity_upgrade.png"),
	"plank": preload("res://global/items/sprites/plank.png"),
	"rock": preload("res://global/items/sprites/rock.png"),
}

var fonts = {
	8: preload("res://resources/font/font_8.tres")
}

var colors = {
	Game_Enums.RARITY.NORMAL : Color( "905c32" ),
	Game_Enums.RARITY.MAGIC : Color( "5b6ee1" ),
	Game_Enums.RARITY.RARE : Color( "999200" ),
	Game_Enums.RARITY.UNIQUE : Color( "bf3d00" ),
}

var tscn = {
	"splitter": preload("res://invRes/splitter.tscn"),
	"hotbar_slot": preload("res://global/inventory/hotbar_slot.tscn"),
	"floor_item": preload("res://global/objects/floor_item.tscn"),
	"cooldown": preload("res://global/items/usable/cooldown.tscn"),
	"quantity": preload("res://global/items/quantity.tscn"),
	"crafting_option": preload( "res://invRes/crafting_option.tscn" ),
	"item_quantity": preload( "res://invRes/item_quantity.tscn" ),
	"inventory_slot": preload( "res://global/inventory/inventory_slot.tscn" ),
	"inventory": preload( "res://global/inventory/inventory.tscn" )
}

var stat_info = {}
var recipes_info = {}

func _ready():
	# Load the stats
	var file = File.new()
	file.open( STAT_PATH, File.READ )
	var data = parse_json( file.get_as_text() )
	for stat in data:
		stat_info[ Game_Enums.STAT[ stat ] ] = data[ stat ]
	file.close()
	
	# Load the recipes
	file.open( RECIPE_PATH, File.READ )
	recipes_info = parse_json( file.get_as_text() )
	file.close()

func get_instance( id ):
	return tscn[ id ].instance()

func get_recipes( id ):
	return recipes_info[ id ]
