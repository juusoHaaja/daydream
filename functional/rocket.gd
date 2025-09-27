extends Node2D

var radiation = false;
var nuke_radius = 45.0;

var nuke_speed = 100.0;
var turn_speed = 3.0;
var target = Vector2.ZERO

static var target_scale = 0.5;

@onready var sprite = $Sprite2D
@export var boom_prefab: PackedScene;
@export var target_marker_prefab: PackedScene;

var target_marker: Sprite2D

func _ready() -> void:
	rotation = (target - global_position).rotated(PI+randf_range(-1.0, 1.0)).angle()
	target_marker = target_marker_prefab.instantiate() as Sprite2D
	target_marker.global_position = target
	target_marker.scale = Vector2.ONE * 0.01
	get_parent().add_child(target_marker)

func _process(delta: float) -> void:
	sprite.scale *= 1-0.3 * delta;
	target_marker.scale = lerp(target_marker.scale, Vector2.ONE * target_scale, 0.05)

	var dir = (target - global_position).normalized()
	var angle_diff = dir.angle_to(global_transform.x)

	rotation -= clamp(angle_diff, -0.5, 0.5) * turn_speed * delta
	global_position += global_transform.x * nuke_speed * delta
	#print("Rocket at ", global_position, " heading to ", target)

	if global_position.distance_to(target) < 300.0:
		turn_speed *= 1.05

	if global_position.distance_to(target) < 50.0:
		explode()

func explode():
	Main.instance.canvas.eliminate(target, nuke_radius)
	var boom = boom_prefab.instantiate()
	boom.global_position = target
	Main.instance.add_child(boom)
	var kills =  get_kills()
	Main.instance.kill_count += kills;
	#print(Main.instance.kill_count, " killed")
	Main.instance.update_kill_count()
	if radiation:
		Main.instance.water_kill.paint_circle(target, int(nuke_radius), Color(0, 1, 0, 0.25))
	
	Main.instance.population -= kills
	if Main.instance.population < 0:
		Main.instance.population = 0

	target_marker.queue_free()
	queue_free()

func get_kills() -> int:
	return Main.instance.water_kill.get_casualities(target, int(nuke_radius))
