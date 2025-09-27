extends Node2D

var nuke_radius = 45.0;

var nuke_speed = 100.0;
var turn_speed = 3.0;
var target = Vector2.ZERO

@onready var sprite = $Sprite2D
@export var boom_prefab: PackedScene;

func _ready() -> void:
    rotation = (target - global_position).rotated(PI+randf_range(-1.0, 1.0)).angle()

func _process(delta: float) -> void:
    sprite.scale *= 1-0.3 * delta;

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
    queue_free()
