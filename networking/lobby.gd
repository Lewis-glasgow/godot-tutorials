extends Node2D


func check_for_ip():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			$player_IP.text = str(ip)
			break
			
func create_client():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client($IP.text,31400)
	get_tree().network_peer = peer

func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(31400,10)
	get_tree().network_peer = peer
	get_tree().change_scene("res://world.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("connected_to_server",self,"server_connected")
	check_for_ip()

func server_connected():
	get_tree().change_scene("res://world.tscn")

func _on_join_pressed():
	create_client()


func _on_host_pressed():
	create_server()
