extends Control

export( NodePath ) onready var player_inventory = get_node( player_inventory ) as Control

func _input( event ):
	if event.is_action_pressed( "inventory" ):
		player_inventory.visible = not player_inventory.visible

func _on_exit_pressed():
	get_tree().quit()
