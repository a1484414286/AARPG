class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var state : String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	pass
	
	
func _process(delta):
	direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left");
	direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up");
	
	velocity = direction * move_speed 
	pass

func _physics_process(delta: float) -> void:
	move_and_slide();
	
func setDirection() -> bool:
	var result : bool = false;
	
	return result;

func setState() -> bool:
	var result : bool = false;
	
	return result;
	
func updateAnimation() -> void:
	pass
