extends CanvasLayer

signal start_game
var go = false

var timer: float = 0.0

var currentScore = 0
var time_since_update = 1000
	
func update_score():
	#Add offset because it collides with doors twice sometimes
	if go and time_since_update > 5:
		currentScore += 1
		$Score.text = str(currentScore)
		time_since_update = 0

func _process(delta):
	timer += delta
	if timer >= 1.0:
		timer -= 1.0  # Subtract 1.0 to keep any leftover fraction for precision
		time_since_update += 1
		


func update_time_left(time):
	$Time_Left.text = str(time)

func _ready():
	$Intro_Song.play()
	$start.pressed.connect(_on_start_button_pressed)
	
func _on_start_button_pressed():
	$start.hide()
	start_game.emit()
	$Score.text = str(0)
	$Intro.hide()
	$Intro_Song.stop()
	$Gaming.play()
	go = true
	$Title.hide()
	

func restart():
	$start.show()
	$Title.show()
	$Gaming.stop()
	$Intro_Song.play()
	go = false;
