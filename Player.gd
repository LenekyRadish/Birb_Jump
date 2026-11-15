extends CharacterBody2D

signal hit
signal hit2
signal hit3
signal hit4

signal beat_1
signal beat_2
signal beat_3
signal beat_4

const SPEED = 300.0
const JUMP_VELOCITY = -700.0
var go = false

@onready var animated_sprite = $AnimatedSprite2D
func _process(delta):
	if velocity.x > 0:
		animated_sprite.play("run")
	elif velocity.x < 0:
		animated_sprite.play("run_flipped")
	else:
		animated_sprite.play("idle")
 

func _physics_process(delta: float) -> void:
	
	if go:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		## Handle jump.
		#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			#velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()
			
		for i in range(get_slide_collision_count()):
			var collision := get_slide_collision(i)
			var collider := collision.get_collider()
			if collider.name == "Floor":
				$Fall_Sound.play()
				hit.emit()
				hide() # Player disappears after being hit.
			if collider.name == "Floor2":
				$Fall_Sound.play()
				hit2.emit()
				hide() # Player disappears after being hit.
			if collider.name == "Floor3":
				$Fall_Sound.play()
				hit3.emit()
				hide() # Player disappears after being hit.
			if collider.name == "Floor4":
				$Fall_Sound.play()
				hit4.emit()
				hide() # Player disappears after being hit.
			if collider.name == "Door1": 
				beat_1.emit()
				$Score_Sound.play()
			if collider.name == "Door2": 
				beat_2.emit()
				$Score_Sound.play()
			if collider.name == "Door3": 
				beat_3.emit()
				$Score_Sound.play()
			if collider.name == "Door4": 
				beat_4.emit()
				$Score_Sound.play()
			if collider.name == "TileMapLayer":
				#bounce
				velocity.y = JUMP_VELOCITY
				$Jump_sound.play()
				#await get_tree().create_timer(0.5).timeout
				#velocity.y = 0
				
		if get_slide_collision_count() == 0:
			show()
func start(pos):
	position = pos
	if go:
		show()
	$CollisionShape2D.disabled = false
func start_processing():
	go = true
func stop_processing():
	go = false
	hide()
