extends Node2D

var airports = []
@export var plane_prefab: PackedScene

func _ready() -> void:
    for child in get_children():
        if child is Node2D:
            airports.append(child.global_position)

func spawn_plane(start_pos):
    var plane = plane_prefab.instantiate()
    plane.global_position = start_pos
    var target_pos = airports[randi() % airports.size()]
    plane.target_position = target_pos
    add_child(plane)
