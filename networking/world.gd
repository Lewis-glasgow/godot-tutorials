extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected",self,"new_player")
	
	var player = preload("res://player.tscn").instance()
	player.set_network_master(get_tree().get_network_unique_id())
	player.name = str(get_tree().get_network_unique_id())
	$players.add_child(player)
	
	for id in get_tree().get_network_connected_peers():
		var p = preload("res://player.tscn").instance()
		p.set_network_master(id)
		p.name = str(id)
		$players.add_child(p)

func new_player(id):
	var p = preload("res://player.tscn").instance()
	p.set_network_master(id)
	p.name = str(id)
	$players.add_child(p)
