extends Node2D

var infection_percent = 1.0

func _ready() -> void:
    pass

func _process(delta: float) -> void:
    if infection_percent > 0.0 and infection_percent <= 100:
        infection_percent += delta
        modulate.g = 1-infection_percent / 100
        modulate.b = 1-infection_percent / 100
        print(infection_percent)
    pass
