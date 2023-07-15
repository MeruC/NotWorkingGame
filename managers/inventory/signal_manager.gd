extends Node

# Inventory
signal inventory_opened(inventory)
signal inventory_closed(inventory)
signal inventory_ready(inventory)
signal player_inventory_ready(inventories)

# Interactables
signal item_picked(item, sender)

# UI
signal ui_scale_changed(value)
