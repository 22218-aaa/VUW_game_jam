extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var list=0
	for enemy in check_areas():
		if enemy.z_index == 1:
			list+=1
	if list==0:
		get_tree().change_scene_to_file("res://scenes/corridor.tscn")
func check_areas():
	var enemies
	enemies = get_overlapping_bodies()
	return enemies
