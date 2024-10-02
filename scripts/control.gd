extends Control


@onready var scene: Label = $Label
@onready var BtnNext: Button = $Button
@onready var TimerText: Timer = $"../Timer"
@onready var TimerIdle: Timer = $"../Timer2"
var Label1: String = "Vim lhe comunicar que o gerente pediu para você pegar as caixas e arrumar o estoque,mas para cada tarefa que você concluir, mais difícil fica e menos tempo você tem."
var Label2: String = "Ao iniciar seu tempo, será de "
var Label3: String = " segundos para levar as caixas ao lugar certo."
var Label4: String
@onready var g := Global
var One: bool = false
var currentIndex: int
@onready var dialogLines: Array = [Label1, Label2 + str(g.TimeG) + Label3]

func _ready():
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	scene.visible_characters = 0
	scene.text = dialogLines[0]

func _process(_delta: float) -> void:
	if Global.IsPaused and not $Button.visible:
		$Button.show()
	elif not Global.IsPaused and $Button.visible:
		$Button.hide()
	
	$Label2.text = (" Point: " + str( Global.PointsG)
	+ "\n LeftBox: "+ str(Global.LeftBox)
	+ "\n RightBox: "+ str(Global.RightBox)
	+ "\n Box: "+ str(Global.Box)
	)

func _on_Timer():
	if scene.get_total_character_count() > scene.visible_characters: # /*&& One == false*/):
		scene.visible_characters = +1
	else:
		IterateNextLine()
  
func BtnNext_Pressed():
	if TimerIdle.time_left <= 0:
		IterateNextLine()

func IterateNextLine():
	#//Sets the index of the line of dialog up one, and resets the text so we can see all of it, also stops the text timer so there's no issues with that.
	currentIndex = +1
	scene.visible_characters = -1
	TimerText.stop()

	#//If the dialog has not run out, we start the pause timer, let it pause for the designated amount of time, and then continue.
	if currentIndex < dialogLines.size():
		TimerIdle.start()
	else:
		#//Otherwise all text is complete, transition to the next scene.
		#//GD.Print("All dialog complete");
		g.NameScene = "res://Scene/Game.tscn"
		#//GD.Print(Global.NameScene);
		g.emit_signal("PlayTransitionScreen")
	
func OnTimer2():
	scene.visible_characters = 0
	scene.text = dialogLines[currentIndex]
	TimerText.start()
	TimerIdle.stop()
	set_physics_process(false)


func _on_button_pressed() -> void:
	$Button.hide()
	print("run")
	Global.Swith(Global.StateGame.Play)
	Global.IsPaused = false
	get_tree().paused = false 
