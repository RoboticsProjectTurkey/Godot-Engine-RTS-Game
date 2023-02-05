extends Node2D

var x = Vector2.ZERO
var y = Vector2.ZERO
var suruklenme = false

func _draw():
	if suruklenme:
		draw_rect(Rect2(x,y-x),Color(1,1,1),false)

func updatee(var a,var b,var c):
	x = a
	y = b
	suruklenme = c
	update()
