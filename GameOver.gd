extends Control

onready var ResultLbl = $Result


# Called when the node enters the scene tree for the first time.
func _ready():
	ResultLbl.text = "Congratulations!\nYour score was: " + str(PlayerVariables.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TryAgainButton_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://Start.tscn")
