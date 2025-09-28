extends Node2D

var target_position = Vector2.ZERO
var speed = 200.0
var start_pos = Vector2.ZERO

func _ready() -> void:
    start_pos = global_position
    var direction = (target_position - global_position).normalized()
    rotation = direction.angle()

func _process(delta: float) -> void:
    var direction = (target_position - global_position).normalized()
    global_position += direction * speed * delta
    rotation = direction.angle()
    if target_position.distance_to(global_position) < 10.0:
        land()
    queue_redraw()

func _draw() -> void:
    draw_line(to_local(start_pos), to_local(target_position), Color.WHITE, 2) #to_local(start_pos)

func land():
    if not Main.instance.water_kill.is_pos_in_sea(target_position):
        Main.instance.canvas.add_point(target_position)
    queue_free()
