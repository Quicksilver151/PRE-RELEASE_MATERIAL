extends MarginContainer

var time = "09:00"
var tickets = 480

func _ready():
	$VBoxContainer/JourneyName.text = "Journey "+self.name

func _process(delta):
	$VBoxContainer/MarginContainer/CenterContainer/VBoxContainer/Time.text = "Time: " + time
	$VBoxContainer/MarginContainer/CenterContainer/VBoxContainer/Tickets.text = "Tickets: " + str(tickets)
	
	
	if tickets == 0:
		$Button.disabled = true
	
	
