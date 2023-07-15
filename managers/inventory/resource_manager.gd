class_name Resource_Manager extends Node

const STAT_PATH = "res://global/items/data/stats.json"

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
}

var fonts = {
	8: preload("res://resources/font/button.tres")
}

var colors = {
	"normal": Color( "905c32" )
}

var tscn = {
	"splitter": preload("res://invRes/splitter.tscn"),
	"hotbar_slot": preload("res://global/inventory/hotbar_slot.tscn"),
	"floor_item": preload("res://global/objects/floor_item.tscn")
}

var stat_info = {}

func _ready():
	var file = File.new()
	file.open( STAT_PATH, File.READ )
	var data = parse_json( file.get_as_text() )
	
	for stat in data:
		stat_info[ Game_Enums.STAT[ stat ] ] = data[ stat ]
	
	file.close()








