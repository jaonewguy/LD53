extends KinematicBody2D

# Shader code from: https://godotengine.org/qa/34070/how-to-make-a-black-sprite-flashing-white
# More reading: https://www.reddit.com/r/godot/comments/pdix1z/how_to_make_2d_sprites_flash_when_hit/

onready var bball = self
onready var animationPlayer = $RotationPivot/AnimationPlayer
onready var fireBG = $RotationPivot/FireBG
onready var implosion_fx = $Implosion
onready var sprite = $RotationPivot/Sprite
onready var flashTimer = $FlashTimer

var is_left_click
var is_drag = false
var is_press = false
var is_release = false

var prev_pos : Vector2
var total_distance : float
var mouse_velocity : Vector2

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
    
    if is_press or is_left_click:
        _start_fx()
        
        if is_drag:
            total_distance += abs(prev_pos.distance_to(get_global_mouse_position()))
            
            print(event.get_speed().abs() * total_distance / 100000)
        else:
            # Reset if not charging up.
            total_distance = 0
    elif is_release:
        _restart_fx()
        
func _start_fx() -> void:
    animationPlayer.play("Spin")
    fireBG.show()
    implosion_fx.show()

func _restart_fx() -> void:
    animationPlayer.stop()
    fireBG.hide()
    fireBG.restart()
    implosion_fx.hide()
    implosion_fx.restart()
    
func _flash_on() -> void:
    sprite.material.set_shader_param("flash_modifier", 0.75)
#    flashTimer.start()
    
func _flash_off() -> void:
    sprite.material.set_shader_param("flash_modifier", 0)
    

func _process(_delta: float) -> void:
    bball.global_position = get_global_mouse_position()
#
#func _physics_process(_delta: float) -> void:
    # taken from: https://godotengine.org/qa/89427/how-to-change-the-cursor-to-an-animated-sprite
#    Input.set_custom_mouse_cursor(frames.get_frame(animation, frame), Input.CURSOR_ARROW, Vector2(frames.get_frame(animation, frame).get_width(), frames.get_frame(animation, frame).get_height()) / 2)


#func _on_FlashTimer_timeout() -> void:
#    _flash_off()
