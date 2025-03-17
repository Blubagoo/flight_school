// File: scripts\fn_displayZoneStatus.sqf

/*
Function: fn_displayZoneStatus
Author: YourName
Date: YYYY-MM-DD
Description: Displays the status of multiple zones with custom formatting.
Parameters:
0: ARRAY - Array of zones and their statuses, e.g., [["Zone 1", true], ["Zone 2", false]]
Returns: None
*/

params ["_zones"];

// Initialize an empty string to hold the combined status
private _statusText = "";

// Iterate over each zone and append its status to the statusText
{
    private _zoneName = _x select 0;
    private _zoneStatus = if (_x select 1) then {"Damaged"} else {"Intact"};
    _statusText = _statusText + format ["%1: %2<br/>", _zoneName, _zoneStatus];
} forEach _zones;

// Apply structured text formatting
private _formattedText = format ["<t size='.8' color='#FFFFFF' align='right'>%1&#160;&#160;&#160;&#160;&#160;&#160;</t>", _statusText];

// Define the position and duration for the display
private _position = [0.6, 0.05]; // X and Y positions (0 to 1 range)
private _duration = 600; // Duration in seconds

// Create a structured text to display
private _structuredText = parseText _formattedText;

// Display the text using BIS_fnc_dynamicText
[_structuredText, _position select 0, _position select 1, _duration, 0, 0, 0, 0] call BIS_fnc_dynamicText;
