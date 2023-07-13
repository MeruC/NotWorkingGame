extends Node

onready var items = {
	"tree" : preload("res://global/items/data/tree.tscn"),
	"stone_brick" : preload("res://global/items/data/stone_brick.tscn"),
	"gold" : preload("res://global/items/data/gold.tscn"),
	"crystal" : preload("res://global/items/data/crystal.tscn"),
}

onready var placeholders = {
	Game_Enums.EQUIPMENT_TYPE.HEAD : preload("res://global/GUI/inventory/sprites/placeholder_head.png"),
	Game_Enums.EQUIPMENT_TYPE.CHEST : preload("res://global/GUI/inventory/sprites/placeholder_chest.png"),
	Game_Enums.EQUIPMENT_TYPE.MAIN_HAND : preload("res://global/GUI/inventory/sprites/placeholder_main_hand.png"),
	Game_Enums.EQUIPMENT_TYPE.OFFHAND : preload("res://global/GUI/inventory/sprites/placeholder_offhand.png"),
}

func get_item( id : String ):
	return items[id].instance()

func get_placeholder(id):
	return placeholders[id]
