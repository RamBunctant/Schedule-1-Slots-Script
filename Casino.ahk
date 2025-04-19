; You will likely have to mess with these values is 
; you're operating system is not exactly the same as 
; the one it was built for. Trial and error!

; Define movement distances (relative, not pixels)
global InitMove := -1900         ; Initial mouse move to the first slot
global Move1 := 650              ; Distance from the frist slot to the second slot
global Move2 := 1050             ; Distance from the second slot to the third slot
global Move3 := 1100             ; Distance from the third slot to the fourth slot
global Move4 := 950              ; Distance from the fourth slot to the fifth slot

global stop := false

; Calculate total distance to move the mouse back to the starting position
global MoveBack := -Move1 - Move2 - Move3 - Move4

; F1 hotkey starts the sequence
F1:: {
    global stop

    ; Move into a position where you can hit all slots
    Send "{Ctrl}"
    Send "{s down}"
    Sleep 750
    Send "{s up}"

    ; Move mouse to first slot
    MoveMouseRelative(InitMove, 0)

    stop := false
    ; Start an infinite loop to hit all slots
    Loop {
	if (stop){
	    break
	}
        pressE()                
        Sleep 200

        MoveMouseRelative(Move1, 0)
        pressE()
        Sleep 200

        MoveMouseRelative(Move2, 0)
        pressE()
        Sleep 200

        MoveMouseRelative(Move3, 0)
        pressE()
        Sleep 200

        MoveMouseRelative(Move4, 0)
        pressE()
        Sleep 200

        ; Move the mouse back to the first slot
        MoveMouseRelative(MoveBack, 0)
        Sleep 2000             ; Wait for slots to reset before repeating
    }
}

; F4 hotkey stops the loop without exiting the script
F4:: {
    global stop 
    stop := true
}

; Function to move the mouse cursor by a relative offset
MoveMouseRelative(dx, dy) {
    ; 0x0001 = MOUSEEVENTF_MOVE (relative move)
    DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", dy, "UInt", 0, "UPtr", 0)
}

; Function to press and release the 'E' key for the slots
pressE() {
    Send "{e down}"
    Sleep 50
    Send "{e up}"
    Sleep 50
}

; F5 hotkey to exit the script
F5::ExitApp