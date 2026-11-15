extends Node

var time_left = 120

var go = false

signal pls_restart

var timer: float = 0.0

func _process(delta: float) -> void:
	if go:
		timer += delta
		if timer >= 1.0:
			timer -= 1.0  # Subtract 1.0 to keep any leftover fraction for precision
			time_left -= 1
		if time_left <= 0:
			game_over_fr()
	
	
	$Display.update_time_left(time_left)

func _ready():
	new_game()

func game_over():
	new_game()
	
func game_over_fr():
	time_left = 120
	go = false
	pls_restart.emit()
	$lil_guy.stop_processing()
	$lil_guy.start($End.position)
	

func new_game():
	$lil_guy.start($StartPos.position)
	
func start_at_2():
	$lil_guy.start($Level_2.position)

func start_at_3():
	$lil_guy.start($Level_3.position)
	
	
func start_at_4():
	$lil_guy.start($Level_4.position)
		
func go_to_2():
	$lil_guy.start($Level_2.position)
	$Display.update_score()

func go_to_3():
	$lil_guy.start($Level_3.position)
	$Display.update_score()
	
func go_to_4():
	$lil_guy.start($Level_4.position)
	$Display.update_score()

func go_to_1():
	$lil_guy.start($StartPos.position)
	$Display.update_score()

	
func start_for_first_time():
	go = true
	$lil_guy.start_processing()
	
func subtract_time():
	if time_left >= 5:
		time_left -= 5
	else:
		time_left = 0


	
	
