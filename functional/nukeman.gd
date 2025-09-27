extends Node2D

@export var rocket_prefab: PackedScene;
@export var rocker_spawn_point: Node2D;

var nuke_radius = 45.0;
var nuke_speed = 400.0;
var speed_mul = 2.0;
var nuke_cooldown = 0.2; #seconds
var nuke_timer = 0.0;

var main
var mouse_pos = Vector2.ZERO

func _process(delta: float) -> void:
	if nuke_timer < 0.0:
		nuke_timer = 0.0
	else:
		nuke_timer -= delta
	handle_input()

func handle_input():
	if Input.is_action_just_pressed("die") and nuke_timer <= 0.0:
		var rocket = rocket_prefab.instantiate()
		rocket.global_position = rocker_spawn_point.global_position
		rocket.target = mouse_pos
		rocket.nuke_radius = nuke_radius
		rocket.nuke_speed = nuke_speed * speed_mul
		rocket.turn_speed = 3.0 * speed_mul
		main.add_child(rocket)
		print("Nuke launched at ", mouse_pos)
		nuke_timer = nuke_cooldown
		#main.canvas.eliminate(mouse_pos, nuke_radius)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_pos = event.global_position
