extends Control


#Popup Types
@onready var confirm_popup: Control = $ConfirmPopup

func decide_type(data: Dictionary) -> void:
	match data["type"]:
		"confirm":
			confirm_popup.show_with_data(data)
