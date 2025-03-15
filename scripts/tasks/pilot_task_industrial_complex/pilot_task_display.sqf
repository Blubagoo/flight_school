// File: scripts\task1\task1_display.sqf

[] spawn {
    while {true} do {
        // Define the zones and their corresponding damage variables
        private _zones = [
            ["Zone 1", missionNamespace getVariable ["zone1Damaged", false]],
            ["Zone 2", missionNamespace getVariable ["zone2Damaged", false]],
            ["Zone 3", missionNamespace getVariable ["zone3Damaged", false]]
        ];

        // Call the custom function to display the zone statuses
        [_zones] call compile preprocessFileLineNumbers "scripts\fn_displayZoneStatus.sqf";

        // Update the display every 5 seconds
        sleep 5;
    };
};
