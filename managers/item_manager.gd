extends Node

onready var items = {
	"tree" : preload("res://global/items/data/tree.tscn"),
	"stone_brick" : preload("res://global/items/data/stone_brick.tscn"),
	"gold" : preload("res://global/items/data/gold.tscn"),
	"crystal" : preload("res://global/items/data/crystal.tscn"),
}

func get_item( id : String ):
	return items[id].instance()
