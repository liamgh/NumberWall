extends Button

onready var button = $"."

export var soundOffText = "Sound Off"
export var soundOnText = "Sound On"


# Called when the node enters the scene tree for the first time.
func _ready():
	showStatus(PlayerVariables.AudioEnabled)

func showStatus(enabled):
	if (enabled):
		button.text = soundOnText
	else:
		button.text = soundOffText



func _on_EnableSoundBtn_pressed():
	PlayerVariables.AudioEnabled = !PlayerVariables.AudioEnabled
	showStatus(PlayerVariables.AudioEnabled)
