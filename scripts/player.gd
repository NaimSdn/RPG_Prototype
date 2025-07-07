extends CharacterBody2D

const speed : int = 100
var last_velocity: Vector2 = Vector2.ZERO
var last_direction: String = "down"

func _physics_process(_delta: float) -> void:
	update_velocity()
	update_animation()
	move_and_slide()
	

func update_velocity() -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if velocity.x != 0 && velocity.y != 0:
		if Input.is_action_just_pressed("move_left") || Input.is_action_just_pressed("move_right"):
			velocity.y = 0
		elif Input.is_action_just_pressed("move_up") || Input.is_action_just_pressed("move_down"):
			velocity.x = 0
		else:
			velocity = last_velocity
	
	velocity = velocity.normalized()
	last_velocity = velocity
	velocity = velocity * speed

func update_animation() -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
		last_direction = "right"
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
		last_direction = "left"
	elif velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
		last_direction = "down"
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
		last_direction = "up"
	else:
		$AnimatedSprite2D.play("idle_" + last_direction)
