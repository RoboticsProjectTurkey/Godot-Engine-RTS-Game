extends KinematicBody2D
onready var main = get_tree().get_current_scene()

var selected = false

var hareket = false
var speed = 80
var hedef = Vector2.ZERO
var velocity = Vector2.ZERO
var yol = []
var last_position = Vector2.ZERO

func _ready():
	$name_label.text = str(get_name())

func select():
	selected = true
	$resim1.visible=false
	$resim2.visible=true

func deselect():
	selected = false
	$resim1.visible=true
	$resim2.visible=false

func _physics_process(delta):
	if hareket == true and timer.is_stopped() == true and espace_to_space() == false:
		yol_olustur()
		yolda()

func _input(event):
	if selected == true and Input.is_action_just_pressed("sag_tik"):
		hareket = true
		hedef = event.position

func yol_olustur():
	yol = main.get_node("Navigation2D").get_simple_path(global_position,hedef,false)
	last_position = yol[0]
	yol.remove(0)

func yolda():
	if yol.size()>0:
		look_at(yol[0])
		velocity=global_position.direction_to(yol[0])*speed
		if global_position==last_position:
			last_position=yol[0]
			yol.remove(0)
			velocity=move_and_slide(velocity)
	if yol.size()<=0:
		timer2.stop()
		hareket=false
		yol=[]
		velocity = Vector2.ZERO
		last_position = Vector2.ZERO

onready var head = $RayCast2D
onready var right1 = $RayCast2D2
onready var right2 = $RayCast2D3
onready var left1 = $RayCast2D4
onready var left2 = $RayCast2D5
onready var right = $Position2D2
onready var left = $Position2D
onready var timer = $Timer
onready var timer2 = $Timer2

func espace_to_space():
	if timer2.is_stopped():
		timer2.start()
	if get_slide_count()!=-1 and head.is_colliding() == true:
		timer.start()
		if right1.is_colliding()==false or right2.is_colliding()==false:
			#look_at(right.global_position)
			velocity = global_position.direction_to(right.global_position)*150
			velocity = move_and_slide(velocity)
			return true
		elif left1.is_colliding()==false or left2.is_colliding()==false:
			#look_at(left.global_position)
			velocity = global_position.direction_to(left.global_position)*150
			velocity = move_and_slide(velocity)
			return true
		else:
			hareket=false
			yol=[]
			velocity = Vector2.ZERO
			last_position = Vector2.ZERO
			return true
	else:
		timer2.stop()
		return false


func _on_Timer2_timeout():
	hareket=false
	yol=[]
	velocity = Vector2.ZERO
	last_position = Vector2.ZERO
