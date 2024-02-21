extends Label

var counter = 0
var label_text = str(counter) + " coins"

func _ready():
	set_text(label_text)

func _on_coin_body_entered(_body):
	counter = counter + 1
	label_text = str(counter) + " coins"
	
	set_text(label_text)
