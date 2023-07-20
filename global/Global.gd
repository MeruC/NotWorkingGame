extends Node

#GLOBAL VARIABLES
var filesystem_shown = false
var edit_mode = true
var can_place = true
var just_onMenu = false

var w = 10
var d = 10

var curOS = OS.get_name()

func _ready():
	print(curOS)
	
var editor_mode = "place"
