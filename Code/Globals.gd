extends Node

# CONSTS
var JourneyInfo =[
	{
		"time":"09:00",
		"tickets":480
	},
	{
		"time":"10:00",
		"tickets":480
	},
	{
		"time":"11:00",
		"tickets":480
	},
	{
		"time":"12:00",
		"tickets":480
	},
	{
		"time":"13:00",
		"tickets":480
	},
	{
		"time":"14:00",
		"tickets":0
	},
	{
		"time":"15:00",
		"tickets":480
	},
	{
		"time":"16:00",
		"tickets":640
	}
]

# INTEFACE VARS
var Col1:String = "242a3a"
var Col2:String = "2f343f"
var Col3:String = "363e55"

var journey_info = []

func _ready():
	assign_color_theme()
	journey_info = JourneyInfo.duplicate(true)
	
	
#	for journey in journey_info:
#		print(journey.time,"\t",journey.tickets)
	
	var journey_nodes = get_tree().get_nodes_in_group("journey")
	
	for node in journey_nodes:
		node.time = journey_info[int(node.name)-1].time
		node.tickets = journey_info[int(node.name)-1].tickets

func assign_color_theme():
	for node in get_tree().get_nodes_in_group("Col1"):
		node.modulate = Color(Col1)
	for node in get_tree().get_nodes_in_group("Col2"):
		node.modulate = Color(Col2)
	for node in get_tree().get_nodes_in_group("Col3"):
		node.modulate = Color(Col3)

func _input(event):
	if event.is_action_pressed("f_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("f_end_screen"):
		pass
	if event.is_action_pressed("f_close_program"):
		get_tree().quit()
	


