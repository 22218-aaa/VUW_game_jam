extends Control
@onready var Menu = $MenuButton
@onready var Pause = $Pause
@onready var Shut = $Control
@onready var timer = $Control/Timer
@onready var lab = $Control/Label2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var popup = Menu.get_popup()
	Shut.visible=false
	$resume.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Shut.visible==true:
		get_tree().paused = true
	elif Pause.text=="x" and Shut.visible==false:
		get_tree().paused = false
	lab.text="If you do nothing the game will shut down automatically in " + str(int(timer.time_left)) + " seconds"

func _on_power_pressed() -> void:
	Shut.visible=true
	timer.start()

func _on_shut_pressed() -> void:
	get_tree().quit()



func _on_pause_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
		Pause.text="x"
		$P.visible=true
		$resume.visible=false
	else:
		get_tree().paused = true
		Pause.text="y"
		$P.visible=false
		$resume.visible=true

func _on_timer_timeout() -> void:
	get_tree().quit()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_cancel_pressed() -> void:
	Shut.visible=false
	timer.stop()


func _on_cuit_pressed() -> void:
	Shut.visible=true
	timer.start()
