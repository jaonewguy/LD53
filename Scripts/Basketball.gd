extends Sprite

onready var bball = self
onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
    pass
    
func _input(event: InputEvent) -> void:
    if event.is_pressed():
        print("Touch screen touched")
        animationPlayer.play("Spin")
    elif not event.is_pressed():
        animationPlayer.stop()
#    else:
#        animationPlayer.stop(false)

func _process(_delta: float) -> void:
    bball.global_position = get_global_mouse_position()
#
#func _physics_process(_delta: float) -> void:
    # taken from: https://godotengine.org/qa/89427/how-to-change-the-cursor-to-an-animated-sprite
#    Input.set_custom_mouse_cursor(frames.get_frame(animation, frame), Input.CURSOR_ARROW, Vector2(frames.get_frame(animation, frame).get_width(), frames.get_frame(animation, frame).get_height()) / 2)
