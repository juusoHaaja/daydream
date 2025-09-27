extends Node2D

@onready var sprite = $Sprite2D

func is_pos_in_sea(pos: Vector2) -> bool:
    var tex = sprite.texture
    if tex == null:
        return false
    var local_pos = to_local(pos)
    var uv = (local_pos / sprite.scale) / tex.get_size() as Vector2
    if uv.x < 0.0 or uv.x > 1.0 or uv.y < 0.0 or uv.y > 1.0:
        return false
    var img = tex.get_image()
    var col = img.get_pixelv((img.get_size() as Vector2 * uv) as Vector2i)
    return col.a > 0.5
