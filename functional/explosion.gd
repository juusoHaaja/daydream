extends Node2D

@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
    sprite.connect("animation_finished", Callable(self, "remove_on_anim_end"))

func remove_on_anim_end() -> void:
    pass
