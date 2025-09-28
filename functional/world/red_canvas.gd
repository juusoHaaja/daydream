extends Node2D
class_name RedCanvas

var main

var max_points = 100;
var points = Array();
var radie = Array();

var centroid = Vector2.ZERO

var border_point = Vector2.ZERO

var grow_frequency = 60.0;
var grow_interval = 1.0 / grow_frequency
var grow_timer = 0.0;

var infected_kills = 0;

func _ready() -> void:
    border_point = get_viewport_rect().end
    add_point($start_node.global_position)
    pass

func _process(delta: float) -> void:
    grow_timer += delta;
    if grow_timer < grow_interval:
        return
    grow_timer -= grow_interval
    if points.size() > 0:
        set_centroid()
        grow()
        if points.size() > max_points:
            reverse_grow()
    if points.size() <= 0:
        Main.instance.set_end_screen()
    queue_redraw()

func _draw() -> void:
    for i in range(points.size()):
        var p = wrap_point(points[i])
        var r = radie[i]

        draw_circle(p, r, Color.RED)

func add_point(pos):
    points.push_back(pos)
    radie.push_back(10)

func wrap_point(point: Vector2) -> Vector2:
    var x = fposmod(point.x, border_point.x)
    var y = fposmod(point.y, border_point.y)
    return Vector2(x, y)


func grow():
    var i = randi_range(0, points.size()-1)
    var p: Vector2 = points[i]
    if randi_range(0, 100) == 69:
        Main.instance.plane_manager.spawn_plane(p)
        return

    var new_p = p+(p-centroid+Vector2.RIGHT).normalized().rotated(randf_range(-1.0, 1.0))*25
    if main.water_kill.is_pos_in_sea(wrap_point(new_p)):
        return
    add_point(new_p)

func reverse_grow():
    var i = randi_range(0, points.size()-1)
    points.remove_at(i)
    radie.remove_at(i)


func set_centroid():
    var sum = Vector2.ZERO
    for p in points:
        sum += p
    centroid = sum / points.size()

func eliminate(pos, radius):
    var length = points.size() -1;
    for i in range(length+1):
        var index = length-i;
        var p = wrap_point(points[index])
        if is_point_overlap(pos, radius, p):
            points.remove_at(index)
            radie.remove_at(index)
            infected_kills += 1
            Main.instance.money += randi_range(1000000000, 5000000000)
            Main.instance.update_money_count()
        

func is_point_overlap(apos: Vector2, ar, bpos: Vector2) -> bool:
    var dist = apos.distance_to(bpos)
    return ar >= dist
