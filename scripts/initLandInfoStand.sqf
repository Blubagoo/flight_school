// initLandInfoStand.sqf - Adds a vanilla scroll menu action to Land_InfoStand_V2_F prop

if (!isServer) then {
    waitUntil { !isNull player && alive player };  // Ensure player exists before proceeding
};

// Locate the prop (ensure it exists in the editor OR dynamically finds the nearest one)
private _infoStand = nearestObject [player, "Land_InfoStand_V2_F"];

if (isNull _infoStand) exitWith {
    diag_log "[Task System] No Land_InfoStand_V2_F found nearby. Exiting...";
};

// Add a vanilla scroll menu action to the object
_infoStand addAction [
    "Create Task",  // Text shown in the scroll menu
    {
        diag_log "[Task System] Calling DestroyTargetTask_createTask from scroll menu..."; 
        
        ["_Task1", "Destroy Enemy Camp", "Eliminate all enemies in the marked zone.", [17894.8,5019.41,0], ["O_Soldier_F"]]   
            remoteExec ["DestroyTargetTask_createTask", 2]; 
        
        diag_log "[Task System] DestroyTargetTask_createTask remoteExec called."; 

        // Repair, Refuel, and Rearm the jet named "bomber1"
        private _jet = missionNamespace getVariable ["bomber1", objNull];

        if (!isNull _jet) then {
            _jet setDamage 0;  // Fully repair
            _jet setFuel 1;  // Refuel to 100%
            _jet setVehicleAmmo 1;  // Rearm to full ammo
            diag_log "[Task System] bomber1 has been fully repaired, refueled, and rearmed.";
        } else {
            diag_log "[Task System] ERROR: Jet 'bomber1' not found!";
        };
    },
    nil,  // No arguments needed
    1.5,  // Interaction distance (meters)
    true,  // Show even when AI uses it
    true,  // Enable action when the object exists
    "",  // No special shortcut key
    "true"  // Condition to display (always available)
];

diag_log "[Task System] Scroll menu action added to Land_InfoStand_V2_F.";
