extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x=randf()
	if x<0.8:
		$Shop.visible=true
	else:
		$Shop.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
