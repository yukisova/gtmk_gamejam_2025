extends CharacterBody2D

var context: Dictionary

func _launch(_context: Dictionary) -> void:
	
	global_position = _context["start_position"]
	context = _context

func _ready() -> void:
	get_tree().create_timer(2.0).timeout.connect(func():
		queue_free()
		)

func _process(_delta: float) -> void:
	velocity = context["start_direction"] * 5000 * _delta
	if global_position.distance_to(context["target_position"]) < 10:
		queue_free()
	move_and_slide()
