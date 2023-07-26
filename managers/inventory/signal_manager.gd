extends Node

# Inventory
signal inventory_opened( inventory )
signal inventory_closed( inventory )
signal inventory_ready( inventory )
signal player_inventory_ready( inventories )
signal item_dropped( item )
signal upgrade_item()
signal has_upgradable_item( value )

# Interactables
signal item_picked( item, sender )

# UI
signal ui_scale_changed( value )

# Player
signal player_life_changed( life, max_life )

# listen to
signal heal_player( health_points )
