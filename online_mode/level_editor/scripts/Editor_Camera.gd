extends KinematicBody

onready var tween = $"../Tween"
onready var camera = $"."

var t = false
var c_rot

export var max_speed = 25
export var acceleration = 200
export var friction = 200
var velocity := Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	c_rot = self.rotation
	t = false

func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_friction(direction, delta)
	apply_movement(input_vector, direction, delta)
	velocity = move_and_slide(velocity, Vector3.UP) 

#Getting The Input
func get_input_vector():
	var input_vector := Vector3.ZERO
	if(Global.editor_mode != "play" and Global.editor_mode != "rotating" and Global.editor_mode != "menu"):
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector

#Getting the Camera Facing Direction
func get_direction(input_vector):
	var direction = (input_vector.x * camera.transform.basis.x) + (input_vector.z * camera.transform.basis.z)
	return direction
	
#Actually Moving the Player
func apply_movement(input_vector, direction, delta):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z

#Friction Physics
func apply_friction(direction, delta):
	if direction == Vector3.ZERO:
		Global.can_place = true
		velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
