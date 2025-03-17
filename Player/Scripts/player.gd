class_name Player extends CharacterBody2D

var cardinal_direction : Vector2 = Vector2.DOWN
var current_direction : Vector2 = Vector2.ZERO
var move_speed : float = 100.0
var current_state : String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	pass
	
	
func _process(delta):
	current_direction.x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left");
	current_direction.y = Input.get_action_strength("player_down") - Input.get_action_strength("player_up");
	
	velocity = current_direction * move_speed 

	# system flowchar =》
	# variable current direction, map direction
	# updateState updates if player is currently idling or walking by checking current direction
	# update Direction updates if x or y is changed (current direction), if yes, update map direction to current direction
	# both gets called to check if player is walking or idling, and which direction	
	# updateAnimation will call directionCheck to get which direction and the state of player
	if updateState() || updateDirection():
		updateAnimation();
	
	pass

func _physics_process(delta: float) -> void:
	move_and_slide();
	
func updateDirection() -> bool:
	#default player will be facing down
	var new_direction : Vector2 = cardinal_direction
	if current_direction == Vector2.ZERO:
		return false;
	
	#this checks if player moved to x or y
	if current_direction.y == 0:
		new_direction = Vector2.LEFT if current_direction.x < 0 else Vector2.RIGHT
	elif current_direction.x == 0:
		new_direction = Vector2.UP if current_direction.y < 0 else Vector2.DOWN
	
	#it checks if new direction is diff from current direction
	#if yes, update player facing animation
	if new_direction == cardinal_direction:
		return false;
		
	cardinal_direction = new_direction
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

#this updates either if player is walking or idling
func updateState() -> bool:
	var new_state : String = "idle" if (current_direction == Vector2.ZERO) else "walk"; 
	if(new_state != current_state):
		current_state = new_state
		return true;
	return false;

#this play the animation of movement + direction based on character animation
func updateAnimation() -> void:
	animation_player.play(current_state + animDirection());
	pass

# this switches direction based on cardinal/map direction
# match = switch, _ = default
func animDirection() -> String:
	match(cardinal_direction):
		Vector2.DOWN:
			return "_down"
		Vector2.UP:
			return "_up"
		Vector2.ZERO:
			return "_idle"
		_:
			return "_side"
