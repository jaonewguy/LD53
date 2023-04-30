extends KinematicBody2D

# Shader code from: https://godotengine.org/qa/34070/how-to-make-a-black-sprite-flashing-white
# More reading: https://www.reddit.com/r/godot/comments/pdix1z/how_to_make_2d_sprites_flash_when_hit/

onready var bball = self
onready var animationPlayer = $RotationPivot/AnimationPlayer
onready var fireBG = $RotationPivot/FireBG
onready var implosion_fx = $Implosion

var is_left_click
var is_drag = false
var is_press = false
var is_release = false

func _ready() -> void:
    pass


# https://stackoverflow.com/questions/68466284/holding-screen-touch-in-godot
# For touch and mouse support.
func _input(event: InputEvent) -> void:
    if !(event is InputEventScreenDrag) and !(event is InputEventScreenTouch) and !(event is InputEventMouse):
        return
        
    is_left_click = event is InputEventMouse and ((event as InputEventMouse).button_mask & BUTTON_LEFT) != 0
    
    is_drag = event is InputEventScreenDrag or (event is InputEventMouseMotion and is_left_click)
    is_press = !is_drag and event.is_pressed()
    is_release = !is_drag and !event.is_pressed()
    
    if is_drag or is_press or is_left_click:
        animationPlayer.play("Spin")
        _start_fx()
    elif is_release:
        animationPlayer.stop()
        _restart_fx()
        
func _start_fx() -> void:
    fireBG.show()
    implosion_fx.show()

func _restart_fx() -> void:
    fireBG.hide()
    fireBG.restart()
    implosion_fx.hide()
    implosion_fx.restart()

func _process(_delta: float) -> void:
    bball.global_position = get_global_mouse_position()
#
#func _physics_process(_delta: float) -> void:
    # taken from: https://godotengine.org/qa/89427/how-to-change-the-cursor-to-an-animated-sprite
#    Input.set_custom_mouse_cursor(frames.get_frame(animation, frame), Input.CURSOR_ARROW, Vector2(frames.get_frame(animation, frame).get_width(), frames.get_frame(animation, frame).get_height()) / 2)
