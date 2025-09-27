extends PathFollow2D

var speed = 1.0

func _process(delta: float) -> void:
    progress_ratio += speed * delta
