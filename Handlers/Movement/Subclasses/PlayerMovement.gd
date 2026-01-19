class_name PlayerMovement
extends MovementHandler

#Responisble for moving the player around
func player_move(speed: float, delta:float):
	#Initializing Cardinal Directions
	var Up = Input.is_action_pressed("MoveUp")
	var Down = Input.is_action_pressed("MoveDown")
	var Right = Input.is_action_pressed("MoveRight")
	var Left = Input.is_action_pressed("MoveLeft")
	
	#Escape if escape is pressed
	if(Input.is_action_pressed("Escape")): _body.get_tree().quit()
	
	#Initilalizing Positions
	var pos : Vector2 = _body.position
	
	#Initializing paths
	#var speed_lvl = CUps.upgrades["Player Upgrades"]["Speed"]["level"]
	#var speed_per_lvl = CUps.upgrades["Player Upgrades"]["Speed"]["effect_per_level"]
	
	#Initilalizing Speeds
	#var accel : float = ((speed + speed_lvl * speed_per_lvl) * delta) 
	#var diag_accel := (sqrt(2 * pow(speed + (speed_lvl * speed_per_lvl), 2)) * delta)/2
	var accel: float = speed * delta
	var diag_accel = (sqrt(pow(speed, 2) * 2) * delta) / 2
	
	#Initializing logic that detects if we are currently going diagonal
	var diag_active := false
	var three_buttons := false
	var count := 0
	
	#Bug Fix: Holding W,A, and D or another combo of 3 numbers causes combination and regular speed to add together
	if Up:
		count +=1
	if Down:
		count +=1
	if Right:
		count +=1
	if Left:
		count +=1
		
	if count >= 3:
		three_buttons = true
	if not three_buttons:
		#Combination
		if Up and Right:
			pos.y -= diag_accel
			pos.x += diag_accel
			diag_active = true
		if Up and Left:
			pos.y -= diag_accel
			pos.x -= diag_accel
			diag_active = true
		if Down and Right:
			pos.y += diag_accel
			pos.x += diag_accel
			diag_active = true
		if Down and Left:
			pos.y += diag_accel
			pos.x -= diag_accel
			diag_active = true
	
	#Regular directions
	if not diag_active:
		if Up:
			pos.y -= accel #Pixels per second
		if Down:
			pos.y += accel
		if Right:
			pos.x += accel
		if Left:
			pos.x -= accel
	
	#Set position
	_body.position = pos

#Forces the player to look at the mouse 
func player_look():
	_body.look_at(_body.get_global_mouse_position())
