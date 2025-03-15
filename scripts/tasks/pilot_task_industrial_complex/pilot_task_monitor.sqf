// File: scripts\task1\task1_monitor.sqf

[] spawn {
    // Wait until all zones are damaged
    waitUntil {
        missionNamespace getVariable ["zone1Damaged", false] &&
        missionNamespace getVariable ["zone2Damaged", false] &&
        missionNamespace getVariable ["zone3Damaged", false]
    };

    // Update task status
    ["task1", "SUCCEEDED"] call BIS_fnc_taskSetState;

    // Inform the player
    ["All zones have been damaged. Task complete!"] call fn_displayText;
};
