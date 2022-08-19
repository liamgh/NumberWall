extends Control

onready var ResultLbl = $Result


# Called when the node enters the scene tree for the first time.
func _ready():
	# compare high score
	if (PlayerVariables.is_high_score()):
		ResultLbl.text = "Congratulations!\nA new high score of %d!" % PlayerVariables.score
		if PlayerVariables.get_high_score() > 0:
			"\nOld high score: %d" % PlayerVariables.get_high_score()
		PlayerVariables.set_high_score()
	else:
		ResultLbl.text = "Congratulations!\nYour score was: %d" % PlayerVariables.score

func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Start.tscn")
