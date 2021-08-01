extends Control


var effect
var recording


# Called when the node enters the scene tree for the first time.
func _ready():
	var idx = AudioServer.get_bus_index("Record")
	effect = AudioServer.get_bus_effect(idx,0)
	effect.set_recording_active(true)


func _on_send_recording_timer_timeout():
	if get_tree().network_peer != null:
		if get_tree().get_network_connected_peers().size() > 0:
			recording = effect.get_recording()
			effect.set_recording_active(false)
			rpc("send_rec_data",recording.data)
			effect.set_recording_active(true)

remote func send_rec_data(rec_data):
	var sample = AudioStreamSample.new()
	sample.data = rec_data
	sample.format = AudioStreamSample.FORMAT_16_BITS
	sample.mix_rate = AudioServer.get_mix_rate()*2
	$AudioStreamPlayer.stream = sample
	$AudioStreamPlayer.play()

func _on_host_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(31400,10)
	get_tree().network_peer = peer


func _on_join_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client("127.0.0.1",31400)
	get_tree().network_peer = peer
