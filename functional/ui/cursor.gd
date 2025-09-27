extends Sprite2D

@export var idle_texture: Texture2D
@export var clicked_texture: Texture2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	texture = idle_texture

func _process(delta: float) -> void:
	# Follow the mouse
	global_position = get_viewport().get_mouse_position()

	# Show clicked texture if left mouse button is pressed, else idle
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		texture = clicked_texture
	else:
		texture = idle_texture
