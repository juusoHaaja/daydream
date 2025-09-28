extends Node2D

var population_density = 22000;
var land_pixels = 374734

@onready var sprite = $Sprite2D
var image: Image;

func _ready() -> void:
    image = sprite.texture.get_image()

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
    return col.g > 0.5

func get_casualities(pos: Vector2, radius: int) -> int:
    calculate_density()

    var sum = 0.0;
    var total = 0;
    pos /= sprite.scale
    radius /= sprite.scale.x
    for y in range(-radius, radius):
        for x in range(-radius, radius):
            var offset = Vector2(x, y)
            if offset.length() <= radius:
                var px = int(pos.x + x)
                var py = int(pos.y + y)

                if px >= 0 and py >= 0 and px < image.get_width() and py < image.get_height():
                    total += 1
                    if image.get_pixel(px, py).g < 0.5:
                        sum += 1.0
    var percentage = sum / total
    return int(population_density * sum)
                        
func calculate_density():
    population_density = Main.instance.population / land_pixels


func paint_circle(pos: Vector2, radius: int, color: Color):
    pos /= sprite.scale
    radius /= sprite.scale.x
    for y in range(-radius, radius):
        for x in range(-radius, radius):
            var offset = Vector2(x, y)
            if offset.length() <= radius:
                var px = int(pos.x + x)
                var py = int(pos.y + y)

                if px >= 0 and py >= 0 and px < image.get_width() and py < image.get_height():
                    if image.get_pixel(px, py).g > 0.5:
                        land_pixels -= 1
                    image.set_pixel(px, py, color)

    sprite.texture = ImageTexture.create_from_image(image) # send updated image to GPU
