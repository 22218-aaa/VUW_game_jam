extends Node2D

func _ready() -> void:
	$player.position.x=(Global.number*1000)+250
	$Camera2D.popsition.x=(Global.number*1000)
	$"Main Menu".position.x=(Global.number*1000)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
