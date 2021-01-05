extends MarginContainer

var journey_info = Global.JourneyInfo.duplicate(true)

onready var journey_nodes = get_tree().get_nodes_in_group("journey")
onready var up_journey = get_tree().get_nodes_in_group("up_journey")
onready var down_journey = get_tree().get_nodes_in_group("down_journey")

onready var confirm_button = $TabContainer/Screen1/TicketSelection/VBoxContainer/CenterContainer/Confirmation

var up_selected = false
var down_selected = false


func _ready():
	print(journey_info)
	
	for i in range(8):
		journey_nodes[i].connect("selected",self,"journey_selected")
	
	$TabContainer/Screen2/NumberSelection.connect("accepted",self,"tickets_accepted")
	$TabContainer/Screen2/NumberSelection.connect("cancelled",self,"tickets_cancelled")
	

func _process(delta):
	# Allow Confirm:
	confirm_button.disabled = !(up_selected and down_selected)
	if confirm_button.pressed:
		switch_tab(1)
	
	test_selected()
	
	# Disable unavailable Buttons due to ticket unavailables
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
		set_pressed(selected)
		
		# Disable Unavailables
		for i in range(4):
			set_disabled(down_journey[i],false,false)
			
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

# Test for if a selection for both up and down is made
func test_selected():
	for node in up_journey:
		if node.pressed:
			up_selected = true
			break
		else:
			up_selected = false
	
	for node in down_journey:
		if node.pressed:
			down_selected = true
			break
		else:
			down_selected = false

#mini funcs
func check_pressed(node):
	return node.get_node("Button").pressed
func set_pressed(node,mode:bool = true):
	node.get_node("Button").pressed = mode
func check_disabled(node):
	return node.get_node("Button").disabled
func set_disabled(node,mode:bool = true,unpress:bool = true):
	node.get_node("Button").disabled = mode
	if unpress:
		node.get_node("Button").pressed = false
func switch_tab(tab):
	$TabContainer.current_tab = tab

func tickets_accepted():
	switch_tab(0)

func tickets_cancelled():
	switch_tab(0)


