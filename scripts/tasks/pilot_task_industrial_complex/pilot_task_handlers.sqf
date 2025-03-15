// File: pilot_task_handlers.sqf

// Ensure the script runs only on the server
if (isServer) then {
    // Define an array of helipad objects by their variable names from the editor
    private _helipads = [helipad1, helipad2, helipad3];

    // Iterate over each helipad
    {
        // Check if the helipad object exists
        if (!isNull _x) then {
            // Add an event handler to detect damage
            _x addEventHandler ["HandleDamage", {
                params ["_target", "_selection", "_damage", "_source", "_projectile"];

                // Define the damage threshold
                private _damageThreshold = 0.1;

                // Check if the damage exceeds the threshold
                if (_damage > _damageThreshold) then {
                    // Execute desired actions upon detecting significant damage
                    hint format ["%1 has been damaged!", _target];
                    // Additional actions can be placed here, such as updating tasks
                };

                // Return the damage value to apply it to the helipad
                _damage;
            }];
        } else {
            diag_log format ["Helipad object %1 not found!", _x];
        };
    } forEach _helipads;
} else {
    diag_log "pilot_task_handlers.sqf executed on a non-server machine.";
};
