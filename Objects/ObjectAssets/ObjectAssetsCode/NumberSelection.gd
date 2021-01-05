extends MarginContainer

onready var display = $VBox/HBox1/NumberDisplay

var tickets = 1

signal accepted
signal cancelled

func _ready():
	display.text = str(tickets)

func _process(delta):
	display.text = str(tickets)


func _on_Minus_pressed():
	if tickets > 1:
		tickets -= 1
func _on_Plus_pressed():
	tickets += 1

func _on_Cancel_pressed():
	emit_signal("cancelled")
func _on_Confirm_pressed():
	emit_signal("accepted")
