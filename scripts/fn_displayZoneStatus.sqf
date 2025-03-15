// File: functions\fn_displayText.sqf

/*
    Function: fn_displayText
    Author: YourName
    Date: YYYY-MM-DD
    Description: Displays the provided text at a fixed position on the screen.
    Parameters:
        0: STRING - Text to display
    Returns: None
*/

params ["_text"];

// Define the position and duration for the display
private _position = [0.85, 0.05]; // X and Y positions (0 to 1 range)
private _duration = 5; // Duration in seconds

// Create a structured text to display
private _structuredText = parseText format ["<t align='right'>%1</t>", _text];

// Display the text using BIS_fnc_dynamicText
[
    [_structuredText, _position select 0, _position select 1, _duration, 0, 0, 0, 0]
] call BIS_fnc_dynamicText;
