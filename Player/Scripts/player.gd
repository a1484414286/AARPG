class_name Player extends CharacterBody2D

var map_direction : Vector2 = Vector2.DOWN
var current_direction : Vector2 = Vector2.ZERO

@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	state_machine.Initialize(self)
	
	pass
	
	
func _process(delta):
	current_direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left");
	current_direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up");
	
	pass

func _physics_process(delta: float) -> void:
	move_and_slide();
	
func updateDirection() -> bool:
	#default player will be facing down
	var new_direction : Vector2 = map_direction
	if current_direction == Vector2.ZERO:
		return false;
	
	#this checks if player moved to x or y
	if current_direction.y == 0:
		new_direction = Vector2.LEFT if current_direction.x < 0 else Vector2.RIGHT
	elif current_direction.x == 0:
		new_direction = Vector2.UP if current_direction.y < 0 else Vector2.DOWN
	
	#it checks if new direction is diff from current direction
	#if yes, update player facing animation
	if new_direction == map_direction:
		return false;
		
	map_direction = new_direction
	sprite_2d.scale.x = -1 if map_direction == Vector2.LEFT else 1
	return true

#this play the animation of movement + direction based on character animation
func updateAnimation(current_state : String) -> void:
	animation_player.play(current_state + animDirection());
	pass

# this switches direction based on cardinal/map direction
# match = switch, _ = default
func animDirection() -> String:
	match(map_direction):
		Vector2.DOWN:
			return "_down"
		Vector2.UP:
			return "_up"
		_:
			return "_side"
