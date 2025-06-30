extends Area2D

var speed = 120 #ความเร็วเคลื่อนที่
var display_size #ขนาดหน้าจอ
signal take_damage #รับความเสียหาย

func _ready() :
	display_size = get_viewport_rect().size
	hide()

func _process(delta) :
	var velocity = Vector2.ZERO #x,y
	
	#รับ input
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	
	#เคลื่อนไหว
	if velocity.length()> 0 :
		velocity = velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	#เคลื่อนที่
	position += velocity*delta
	
	#ตั้งค่าขอบเขตการเคลื่อนที่
	position = position.clamp(Vector2.ZERO, display_size)
	
	#Flip animation
	if velocity.x != 0 :
		$AnimatedSprite2D.animation = "Walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.flip_v = false #ไม่สามารถพลิกตัวในแนวตั้้งได้
		
	if velocity.y != 0 :
		$AnimatedSprite2D.animation = "UP"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		$AnimatedSprite2D.flip_h = false


func _on_body_entered(body: Node2D) -> void:
	print("ไอโง่โดนชน")
	hide()
	take_damage.emit()
	$CollisionShape2D.set_deferred("disabled",true)

func create_player(point):
	position = point
	show()
	$CollisionShape2D.disabled = false
