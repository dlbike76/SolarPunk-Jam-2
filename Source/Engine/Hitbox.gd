tool
extends Node2D

export(String, "1 pixel", "16 pixel") var pixels := ""
export var x := 0
export var y := 0
export var width := 1
export var height := 1
export var color := Color(0,0,1,0.5)

# coordinates of the rectangle. (rx,ry) is the position of the rectangle (top-left corner by default), and (rx_w,ry_h) is the bottom-right corner
var rx setget ,get_rx 
var rx_w setget ,get_rx_w 
var ry setget ,get_ry 
var ry_h setget ,get_ry_h 

func _draw() -> void:
	if pixels == "1 pixel" : draw_rect(Rect2(x,y,width,height), color)
	elif pixels == "16 pixel" : draw_rect(Rect2(x,y,width*16,height*16), color)

func _physics_process(_delta: float) -> void:
	update()

func intersects(other, offset) -> bool:
	return(
		(self.rx + offset.x)  < other.rx_w &&  
		(self.rx_w + offset.x) > other.rx &&
		(self.ry + offset.y)  < other.ry_h &&    
		(self.ry_h + offset.y) > other.ry 
		)

func get_rx():
	return global_position.x + x

func get_rx_w():
	if pixels == "1 pixel" : return global_position.x + x + width
	else : return global_position.x + x + (width * 16)
	
func get_ry():
	return global_position.y + y

func get_ry_h():
	if pixels == "1 pixel" : return global_position.y + y + height
	else : return global_position.y + y + (height * 16)

