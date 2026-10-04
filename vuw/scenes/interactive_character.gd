extends Node2D
var main :int=0
var list=["Commander: Hello Agent, you have been tasked with an important infiltration job.", "Agent: Aye Sir, what has happened, why have you called me here to a forest instead of messaging me?", "Commander: As you might know with the invasion of the alien species we have been relying on hiding our communications through the fact that they don't know our language.", "Agent: Yeah", "Commander: Well we have recently learnt that the Enemy has translated some of our plans, their linguistic and decoding ability is beyond anything we know of and most of our messsages are leaked.", "Agent: Oh no, was that how the HQ was attacked recently with a thermonuclear warhead", "Commander: Yes, the truth is that we are in grave danger and the war is almost lost however higher command has decided to launch a mission to attack the mothership of the aliens, we plan to detonate a newly designed antimatter weapon there.", "Agent: Wait antimatter, that is very dangerous.", "Commander: Yes its the last resort that needs to be done: Infiltrate the ship and detonate the device."]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if main==8:
		get_tree().change_scene_to_file("res://tutorial.tscn")
	$Label.text=list[main]


func _on_button_pressed() -> void:
	main+=1
