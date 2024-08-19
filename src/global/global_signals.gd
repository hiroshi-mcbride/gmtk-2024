extends Node

enum Type {
	START_GAME,
	PAUSE,
	RESUME,
	QUIT_TO_MAIN_MENU,
	MOUSE_OVER_ENTERED,
	MOUSE_OVER_EXITED
}

signal game_started()
signal game_paused()
signal game_resumed()
signal game_quit()
signal mouse_over_entered()
signal mouse_over_exited()

var signals = { 
	Type.START_GAME : game_started,
	Type.PAUSE : game_paused,
	Type.RESUME : game_resumed,
	Type.QUIT_TO_MAIN_MENU : game_quit,
	Type.MOUSE_OVER_ENTERED : mouse_over_entered,
	Type.MOUSE_OVER_EXITED : mouse_over_exited,
}
