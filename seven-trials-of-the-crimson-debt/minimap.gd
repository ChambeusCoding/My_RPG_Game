extends CanvasLayer

@onready var minimap_camera: Camera2D = $UI/MarginContainer/SubViewportContainer/SubViewport/MinimapCamera
@onready var player_marker: ColorRect = $UI/MarginContainer/SubViewportContainer/SubViewport/PlayerMarker
@onready var sub_viewport: SubViewport = $UI/MarginContainer/SubViewportContainer/SubViewport
@onready var sub_viewport_container: SubViewportContainer = $UI/MarginContainer/SubViewportContainer

var player_node: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
