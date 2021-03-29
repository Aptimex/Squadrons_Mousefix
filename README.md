# Squadrons_Mousefix
AutoHotkey script to make Star Wars Squadrons mouse controls usable. 

By default the `F8` key toggles the script on an off. See https://www.autohotkey.com/docs/KeyList.htm for how to customize the toggle key.

`jump_distance` defines how far (in pixels) it will move the mouse towards the deadzone with each poll; higher = more pull.

`deadzone` defines the pixel radius around around the neutral position where the script won't do anything.

Each time the script starts, the current mouse position is defined as the new neutral (target) location.
