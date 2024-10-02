extends Node

enum StateGame {Play, Pause, Null}

var TimeG: float = 120.0
var PointsG: int = 0
var LevelG: int = 1
var Box: int = 0
var LeftBox = 0
var RightBox = 0
var Left: Color
var Right: Color
var NextString
  
var Current: StateGame = StateGame.Play
var NameScene: String = ""
var StateNext: StateGame = StateGame.Null
var IsPaused: bool = false



var data = {
  "Language": "en_US",
  "right": "A",
  "left": "D",
  "Pause": "Space",
}

var d_right: String = "A"
var d_left: String = "D"
var d_Pause: String = "Space"

#signal PlayTransitionScreen()
#signal PlayLoadingScreen()

func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("stop") and not IsPaused:
		IsPaused = true
		print("paused")
		Swith(StateGame.Pause)
		get_tree().paused = true # Pausa o jogo
	elif event.is_action_pressed("stop") and IsPaused:
		IsPaused = false
		print("run")
		Global.Swith(StateGame.Play)
		get_tree().paused = false  # Despausa o jogo

	
func Swith(_StateNext: StateGame):
	Current = _StateNext

#Recebe o menu
func GetMenu():
	return Current
