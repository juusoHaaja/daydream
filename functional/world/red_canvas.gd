extends Node2D

var points = Array();
var radie = Array();

func _ready() -> void:
    add_point(Vector2(0, 0))

func _process(delta: float) -> void:
    queue_redraw()

func _draw() -> void:
    for i in range(0, points.size()):
        var p = points[i]
        var r = radie[i]

        draw_circle(p, r, Color.RED)

func add_point(pos):
    points.push_back(pos)
    radie.push_back(10)

func grow():
    pass