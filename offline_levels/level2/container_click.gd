extends Button

var letter 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_blank1_pressed():
	letter = self.text
	self.text = "_"
	for child in $"../../letter_container".get_children():
		if child.text == letter:
			if child.disabled == true:
				child.disabled = false
				return
			
