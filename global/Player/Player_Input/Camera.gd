extends Spatial

onready var tween = $"../Tween"
onready var camera = $"."

var t = false
var c_rot


# Called when the node enters the scene tree for the first time.
func _ready():
	c_rot = self.rotation
	t = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if t == false:
		if(Input.is_action_just_pressed("camera_rotate_left")):
			t = true
			c_rot += Vector3(0,PI/-4,0)
			tween.interpolate_property(camera, "rotation", camera.rotation, c_rot, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
		if(Input.is_action_just_pressed("camera_rotate_right")):
			t = true
			c_rot += Vector3(0,PI/4,0)
			tween.interpolate_property(camera, "rotation", camera.rotation, c_rot, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			tween.start()
			
			

func _on_Tween_tween_completed(object, key):
	t = false
	pass # Replace with function body.
