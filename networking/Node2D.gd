extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_network_master():
		if Input.is_action_pressed("down"):
			position.y += 2
		if Input.is_action_pressed("up"):
			position.y -= 2
		if Input.is_action_pressed("left"):
			position.x -= 2
		if Input.is_action_pressed("right"):
			position.x += 2
		
	rpc_unreliable("set_pos",global_position)
	
remote func set_pos(pos):
	global_position = pos
