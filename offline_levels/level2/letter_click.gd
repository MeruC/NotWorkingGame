extends Button

export(NodePath) onready var blank_container = get_node(blank_container) as GridContainer
export(NodePath) onready var submit_button = get_node(submit_button) as Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	self.disabled = true
	var x = 0
	for child in blank_container.get_children():
		if child.text == "_":
			child.text = self.text
			return
		
			
	
	
