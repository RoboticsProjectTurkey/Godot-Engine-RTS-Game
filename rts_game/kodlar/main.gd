extends Node2D

var secme_kutusu = RectangleShape2D.new()
var suruklenme = false
var position1 = Vector2.ZERO
var secilenler = []
var eski_secilenler = []

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			var x=0
			while x <= eski_secilenler.size()-1:
				eski_secilenler[x].collider.deselect()
				x+=1
			eski_secilenler=[]
			suruklenme = true
			position1=event.position
		elif suruklenme:
			suruklenme = false
			$draw.updatee(position1,event.position,suruklenme)
			secme_kutusu.extents = (event.position-position1)/2
			var space = get_world_2d().direct_space_state
			var sorgu = Physics2DShapeQueryParameters.new()
			sorgu.set_shape(secme_kutusu)
			sorgu.transform = Transform2D(0,(event.position+position1)/2)
			secilenler = space.intersect_shape(sorgu,100)
			var x=0
			while x<=secilenler.size()-1:
				if secilenler[x].collider.is_in_group("mans"):
					secilenler[x].collider.select()
					eski_secilenler.append(secilenler[x])
				x+=1
	if suruklenme:
		$draw.updatee(position1,event.position,suruklenme)
	
	if secilenler.size()>0:
		$target_point.visible = true
		$target_point.position = event.position
	else:
		$target_point.visible = false
	
