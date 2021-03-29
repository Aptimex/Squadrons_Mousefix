;#################################################
;# https://github.com/Aptimex/Squadrons_Mousefix #
;#################################################

#MaxThreadsPerHotkey 2		;needed so that un-toggle will fire
F8::
Toggle := !Toggle

; Max pixels to move each loop
jump_distance := 50

; Center zone size to consider "target"; enables more precise small movements when at "rest"
deadzone := 150

; Set to 1 to make movement more jerky, if you want that for some reason; anything >1 will probably be unusable
jump_delay = 0

; Get target position to lock to on toggle
MouseGetPos,xStart,yStart

; Use these instead of the above MouseGetPos to always move towards actual screen center
; Might not work as expected with multi-monitor setups
;xStart :=  A_ScreenWidth //2
;yStart :=  A_ScreenHeight //2

while Toggle
{
	; Reset to default
	jump := jump_distance
	
	; Get current mouse position
	MouseGetPos,x1,y1
	
	; Get movement needed to return to target position
	xDelta := (xStart - x1)
	yDelta := (yStart - y1)
	
	; Get total distance (straight-line) to target via A^2+B^2=C^2
	distance := Sqrt(xDelta*xDelta + yDelta*yDelta)
	if (distance <= deadzone) { ;don't pull mouse if inside deadzone
		continue
	}
	
	; Get relative fraction of component distances
	xWeight := (xDelta / distance)
	yWeight := (yDelta / distance)
	
	; Stop pulling mouse when it reaches deadzone, not target
	total_distance := (distance - deadzone)
	if (total_distance < jump) {
		jump := total_distance
	}
	
	; Calculate component deltas to move towards target; linear distance bounded to jump
	newX := MinMagnitude(jump * xWeight, xDelta)
	newY := MinMagnitude(jump * yWeight, yDelta)
	
	; Move mouse (Relative to current position) towards target
	MouseMove, newX, newY, jump_delay, R
}
return

MinMagnitude(a, b) {
	c := Abs(a)
	d := Abs(b)
	if Min(c,d) == c {
		return a
	}
	return b
}

; Ctrl+Escape is an emergency stop in case it gets stuck; useful for dev
^Esc::ExitApp