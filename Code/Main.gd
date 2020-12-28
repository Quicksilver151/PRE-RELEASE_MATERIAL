extends MarginContainer

var journey_info = Global.JourneyInfo.duplicate(true)

onready var journey_nodes = get_tree().get_nodes_in_group("journey")
onready var up_journey = get_tree().get_nodes_in_group("up_journey")
onready var down_journey = get_tree().get_nodes_in_group("down_journey")

var up_selected = false
var down_selected = false


func _ready():
	print(journey_info)
	
	for i in range(8):
		journey_nodes[i].connect("selected",self,"journey_selected")
		

func _process(delta):
	if up_selected and down_selected:
		$Margin/VBoxContainer/CenterContainer/Confirmation.disabled = false
	
	
	
	# Disable unavailable Buttons
	for i in range(4):
		var j = 3-i
		if check_disabled(down_journey[j]):
			set_disabled(up_journey[j])
		else:
			break

# Select only one Button
func journey_selected(node):
	var selected
	if node.is_in_group("up_journey"):
		selected = node
		for i in range(4):
			set_pressed(up_journey[i],false)
		up_selected = true
		set_pressed(selected)
		
		# Disable Unavailables
		for i in range(4):
			set_disabled(down_journey[i],false)
			
		var pos = node.get_index()
		if pos >= 0:
			for i in range(4):
				if down_journey[i].get_index() < pos:
					set_disabled(down_journey[i],true)
	
	if node.is_in_group("down_journey"):
		selected = node
		for i in range(4):
			set_pressed(down_journey[i],false)
		set_pressed(selected)
		down_selected = true
	

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.pressed:
#			if get_focus_owner() != null:
#				get_focus_owner().pressed = false


#mini funcs
func check_pressed(node):
	return node.get_node("Button").pressed
func set_pressed(node,mode:bool = true):
	node.get_node("Button").pressed = mode
func check_disabled(node):
	return node.get_node("Button").disabled
func set_disabled(node,mode:bool = true):
	node.get_node("Button").disabled = mode


